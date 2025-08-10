import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/chat/chat.dart' as eco;
import 'package:ecotrip/ui/chats/store/chats_store.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final InMemoryChatController _chatController = InMemoryChatController();

  late final ChatsStore _chatsStore = getIt<ChatsStore>();

  eco.Chat? _chatSummary;
  eco.ChatInfo? _chatInfo;
  String? _currentUserId;
  bool _isInitializing = true;

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize once when route arguments become available
    if (_isInitializing) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is eco.Chat) {
        _chatSummary = args;
      }
      _initializeFromApi();
    }
  }

  Future<void> _initializeFromApi() async {
    try {
      // Resolve current user id from JWT
      final token = await getIt<Repository>().authToken;
      if (token != null) {
        final jwt = JWT.decode(token);
        final userId = jwt.payload['userId'];
        _currentUserId = userId?.toString();
      }

      if (_chatSummary?.id != null) {
        final info = await _chatsStore.getChatInfo(_chatSummary!.id!);
        _chatInfo = info;
        // Hydrate messages from API into the controller (oldest first)
        final messages = (info.messages ?? <eco.ChatMessage>[])..sort(
            (a, b) => (a.createdAt ?? DateTime(0))
                .compareTo(b.createdAt ?? DateTime(0)));
        for (final m in messages) {
          _chatController.insertMessage(
            TextMessage(
              id: (m.id ?? Random().nextInt(1000000)).toString(),
              authorId: (m.senderId ?? -1).toString(),
              createdAt: (m.createdAt ?? DateTime.now()).toUtc(),
              text: m.message ?? '',
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: _buildTitle()),
      body: Chat(
        chatController: _chatController,
        currentUserId: _currentUserId ?? '0',
        onMessageSend: (text) async {
          final chatId = _chatSummary?.id;
          if (chatId == null) return;
          final sent = await _chatsStore.sendMessage(chatId, text);
          if (sent) {
            _chatController.insertMessage(
              TextMessage(
                id: '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(100000)}',
                authorId: _currentUserId ?? '0',
                createdAt: DateTime.now().toUtc(),
                text: text,
              ),
            );
          }
        },
        resolveUser: (UserID id) async => _resolveUser(id),
      ),
    );
  }

  String _buildTitle() {
    // Prefer names from chat info; fall back to summary
    final participants = _chatInfo?.participants ?? _chatSummary?.chatData?.participants;
    if (participants == null || participants.isEmpty) return 'Chat';
    final names = participants.map((p) => p.name ?? 'Usuario').toList();
    if (names.length == 1) return names.first;
    if (names.length == 2) return '${names[0]} y ${names[1]}';
    return '${names[0]} y ${names.length - 1} más';
  }

  Future<User> _resolveUser(UserID id) async {
    final idStr = id;
    final idInt = int.tryParse(idStr);
    // Current user
    if (_currentUserId != null && idStr == _currentUserId) {
      return User(id: idStr, name: 'Tú');
    }
    // Search in participants
    final participants = _chatInfo?.participants ?? _chatSummary?.chatData?.participants;
    final match = participants?.firstWhere(
      (p) => p.id == idInt,
      orElse: () => eco.ChatParticipant(id: idInt, name: 'Usuario $idStr'),
    );
    return User(id: idStr, name: match?.name ?? 'Usuario');
  }
}
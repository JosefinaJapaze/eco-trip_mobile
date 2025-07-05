import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/models/chat/chat.dart';
import 'package:ecotrip/ui/chats/store/chats_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/base_app_bar.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ChatsStore _chatsStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatsStore = getIt<ChatsStore>();
    _chatsStore.fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: "chats_title"),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Observer(
          builder: (context) {
            if (_chatsStore.isLoading) {
              return Container();
            }
            return _buildChatsList();
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _chatsStore.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatsList() {
    if (_chatsStore.chatsFuture.value?.isEmpty ?? true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              "No tienes conversaciones activas",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Únete a un viaje para comenzar a chatear",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Mis conversaciones",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: _chatsStore.chatsFuture.value?.length ?? 0,
            itemBuilder: (context, index) {
              final chat = _chatsStore.chatsFuture.value![index];
              return _buildChatCard(chat);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatCard(Chat chat) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        color: Color.fromARGB(255, 242, 255, 244),
        child: InkWell(
          onTap: () {
            // Navigate to chat detail screen
            // Navigator.of(context).pushNamed("/chat_detail", arguments: chat);
            Navigator.of(context).pushNamed(Routes.chat, arguments: chat);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Abrir chat del viaje #${chat.tripId}"),
                duration: Duration(seconds: 2),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.lime,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.group,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                                Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _getParticipantNames(chat),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                _formatTime(chat.lastMessageTime),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                      SizedBox(height: 4),
                      Text(
                        chat.lastMessage ?? "Sin mensajes",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Viaje #${chat.tripId}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getParticipantNames(Chat chat) {
    if (chat.chatData?.participants?.isEmpty ?? true) {
      return "Sin participantes";
    }
    
    final names = chat.chatData!.participants!.map((p) => p.name ?? "Usuario").toList();
    
    if (names.length == 1) {
      return names.first;
    } else if (names.length == 2) {
      return "${names[0]} y ${names[1]}";
    } else {
      return "${names[0]} y ${names.length - 1} más";
    }
  }

  String _formatTime(DateTime? time) {
    if (time == null) return "";
    
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return "hace ${difference.inMinutes}m";
    } else if (difference.inHours < 24) {
      return "hace ${difference.inHours}h";
    } else if (difference.inDays < 7) {
      return "hace ${difference.inDays}d";
    } else {
      return DateFormat('dd/MM').format(time);
    }
  }
}

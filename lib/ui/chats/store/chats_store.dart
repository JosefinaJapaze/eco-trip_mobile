import 'package:ecotrip/data/network/apis/chat/chat_api.dart';
import 'package:ecotrip/models/chat/chat.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'chats_store.g.dart';

class ChatsStore = _ChatsStore with _$ChatsStore;

abstract class _ChatsStore with Store {
  final ChatApi _chatApi;
  final ErrorStore errorStore = ErrorStore();

  _ChatsStore(ChatApi api) : this._chatApi = api {
    _setupDisposers();
  }

  @observable
  bool success = false;

  @observable
  ObservableFuture<List<Chat>> chatsFuture = ObservableFuture.value([]);

  @computed
  bool get isLoading => chatsFuture.status == FutureStatus.pending;

  @action
  void setSuccess(bool value) {
    success = value;
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  @action
  Future<List<Chat>> fetchChats() async {
    try {
      final future = _chatApi.getMyChats();
      chatsFuture = ObservableFuture(future);
      List<Chat> chats = await future;
      return chats;
    } catch (e) {
      errorStore.errorMessage = 'Error al obtener chats';
      return [];
    }
  }

  @action
  Future<bool> sendMessage(int chatId, String message) async {
    try {
      final future = _chatApi.sendMessage(chatId, message);
      return await future;
    } catch (e) {
      errorStore.errorMessage = 'Error al enviar mensaje';
      return false;
    }
  }

  @action
  Future<ChatInfo> getChatInfo(int chatId) async {
    try {
      final future = _chatApi.getChatInfo(chatId);
      return await future;
    } catch (e) {
      errorStore.errorMessage = 'Error al obtener información del chat';
      return ChatInfo();
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
} 
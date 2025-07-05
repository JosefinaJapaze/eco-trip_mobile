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
  Future<bool> sendMessage(String chatId, String message) async {
    try {
      // Mock implementation
      await Future.delayed(Duration(milliseconds: 500));
      this.success = true;
      // Refresh chats after sending message
      await fetchChats();
      return true;
    } catch (e) {
      this.success = false;
      errorStore.errorMessage = 'Error al enviar mensaje';
      return false;
    }
  }

  Future<List<Chat>> _getMockChats() async {
    // Mock delay to simulate API call
    await Future.delayed(Duration(milliseconds: 800));
    
    return [
      Chat(
        id: 1,
        tripId: 101,
        chatData: ChatData(
          driverId: 1,
          driverName: "Juan Pérez",
          participants: [
            ChatParticipant(name: "María González"),
            ChatParticipant(name: "Carlos Ruiz"),
          ],
        ),
        lastMessage: "¡Perfecto! Nos vemos mañana a las 8:00 AM",
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 15)),
      ),
      Chat(
        id: 2,
        tripId: 102,
        chatData: ChatData(
          driverId: 2,
          driverName: "Ana López",
          participants: [
            ChatParticipant(name: "Luis Fernández"),
          ],
        ),
        lastMessage: "¿Podrías pasar por mi casa?",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
      ),
      Chat(
        id: 3,
        tripId: 103,
        chatData: ChatData(
          driverId: 3,
          driverName: "Miguel Torres",
          participants: [
            ChatParticipant(name: "Ana Martínez"),
            ChatParticipant(name: "Elena Vargas"),
            ChatParticipant(name: "Roberto Silva"),
          ],
        ),
        lastMessage: "Gracias por el viaje, fue muy cómodo",
        lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
      ),
      Chat(
        id: 4,
        tripId: 104,
        chatData: ChatData(
          driverId: 4,
          driverName: "Sofia Mendoza",
          participants: [
            ChatParticipant(name: "Luis Fernández"),
            ChatParticipant(name: "Carmen Díaz"),
          ],
        ),
        lastMessage: "¿A qué hora salimos?",
        lastMessageTime: DateTime.now().subtract(Duration(hours: 5)),
      ),
      Chat(
        id: 5,
        tripId: 105,
        chatData: ChatData(
          driverId: 5,
          driverName: "Diego Ramírez",
          participants: [
            ChatParticipant(name: "Elena Vargas"),
          ],
        ),
        lastMessage: "Perfecto, llego en 10 minutos",
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 45)),
      ),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
} 
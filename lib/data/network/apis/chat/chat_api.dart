import 'package:dio/dio.dart';
import 'package:ecotrip/data/network/constants/endpoints.dart';
import 'package:ecotrip/data/network/exceptions/network_exceptions.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/chat/chat.dart';

class ChatApi {
  final RestClient _restClient;
  final Repository _repository;

  ChatApi(this._restClient, this._repository);

  Future<List<Chat>> getMyChats() async {
    return _repository.authToken.then((token) {
      return _restClient.get(Endpoints.myChats, headers: {
        "Authorization": "Bearer $token",
      }).then((dynamic res) {
        var resMap = res as List<dynamic>;
        return resMap.map((e) => Chat.fromMap(e)).toList();
      }).catchError((e) {
        if (e is DioException) {
          print("Dio exception: ${e.message}; ${e.response}");
        }
        throw NetworkException(message: e.toString());
      });
    });
  }

  Future<bool> sendMessage(int chatId, String message) async {
    return _repository.authToken.then((token) {
      return _restClient.post(Endpoints.messages, headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "chat_id": chatId,
        "message": message,
      }).then((dynamic res) {
        return true;
      }).catchError((e) {
        if (e is DioException) {
          print("Dio exception: ${e.message}; ${e.response}");
        }
        return false;
      });
    });
  }

  Future<ChatInfo> getChatInfo(int chatId) async {
    return _repository.authToken.then((token) {
      return _restClient.get(Endpoints.chats + "?chat_id=$chatId", headers: {
          "Authorization": "Bearer $token",
      }).then((dynamic res) {
        return ChatInfo.fromMap(res);
      }).catchError((e) {
        if (e is DioException) {
          print("Dio exception: ${e.message}; ${e.response}");
        }
        throw NetworkException(message: e.toString());
      });
    });
  }
}

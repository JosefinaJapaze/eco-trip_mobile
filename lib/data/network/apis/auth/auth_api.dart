import 'dart:async';

import 'package:ecotrip/data/network/constants/endpoints.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/data/network/exceptions/network_exceptions.dart';
import 'package:ecotrip/models/auth/auth.dart';

class AuthApi {
  // rest-client instance
  final RestClient _restClient;

  AuthApi(this._restClient);

  Future<LoginResult> login(String username, String password) {
    return _restClient.post(Endpoints.login, body: {
      "username": username,
      "password": password,
    }).then((dynamic res) {
      return LoginResult(
        resultStatus: AuthResultStatus.successful,
        token: res["token"],
      );
    }).catchError((e) {
      if (e is AuthException) {
        return LoginResult(resultStatus: AuthResultStatus.wrongCredentials);
      }
      throw NetworkException(message: e.toString());
    });
  }
}

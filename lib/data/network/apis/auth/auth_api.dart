import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/network/exceptions/network_exceptions.dart';
import 'package:boilerplate/models/auth/auth.dart';

class TripApi {
  // rest-client instance
  final RestClient _restClient;

  TripApi(this._restClient);

 Future<LoginResult> login(String username, String password) {
    return _restClient.post(Endpoints.login, body: {
      "username": username,
      "password": password,
    }).then((dynamic res) {
      return LoginResult(
        resultStatus: AuthResultStatus.successful,
        token: res["token"],
        refreshToken: res["refreshToken"],
      );
    }).catchError((e) {
       if (e is AuthException) {
        return LoginResult(resultStatus: AuthResultStatus.wrongCredentials);
       }
       throw NetworkException(message: e.toString());
    });
  }
}

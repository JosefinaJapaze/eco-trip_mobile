import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/network/exceptions/network_exceptions.dart';
import 'package:boilerplate/models/auth/auth.dart';
import 'package:boilerplate/models/user/register_result.dart';

enum Gender {
  male,
  female
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final Gender gender;
  final DateTime birthDate;
  final String phone;
  final String email;
  final String password;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender.toString(),
      "birthDate": birthDate.toIso8601String(),
      "phone": phone,
      "email": email,
      "password": password,
    };
  }
}

class RegisterApi {
  // rest-client instance
  final RestClient _restClient;

  RegisterApi(this._restClient);

  Future<RegisterResult> register(RegisterParams params) {
      return _restClient.post(Endpoints.register, body: params.toJson()).then((dynamic res) {
        return RegisterResult(
          resultStatus: AuthResultStatus.successful,
          token: res["token"],
          refreshToken: res["refreshToken"],
        );
      }).catchError((e) {
        if (e is AuthException) {
          return RegisterResult(resultStatus: AuthResultStatus.wrongCredentials);
        }
        throw NetworkException(message: e.toString());
      });
    }
}

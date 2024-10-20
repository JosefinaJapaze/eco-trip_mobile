import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/network/exceptions/network_exceptions.dart';
import 'package:boilerplate/models/auth/auth.dart';
import 'package:boilerplate/models/user/register_result.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

Gender? genderFromString(String value) {
  if (value == "male") {
    return Gender.male;
  } else if (value == "female") {
    return Gender.female;
  } else {
    return null;
  }
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final Gender gender;
  final DateTime birthDate;
  final int phone;
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

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender.toString(),
      "birth_date": birthDate.toUtc().toIso8601String(),
      "phone_number": phone,
      "email": email,
      "password": password,
    };
  }
}

class RegisterApi {
  final RestClient _restClient;

  RegisterApi(this._restClient);

  Future<String> getPresignedURL(String documentType) {
    return _restClient.post(
      Endpoints.getPresignedURL,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_restClient.userToken"
      },
      body: {"document_type": documentType},
    ).then((dynamic res) {
      return res.toString();
    }).catchError((e) {
      throw NetworkException(message: e.toString());
    });
  }

  Future<RegisterResult> register(RegisterParams params) {
    return _restClient
        .post(
          Endpoints.register,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(params.toJson()),
          )
        .then((dynamic res) {
      return RegisterResult(
        resultStatus: AuthResultStatus.successful,
        token: res["token"],
        refreshToken: res["refreshToken"],
      );
    }).catchError((e) {
      if (e is BadRequestException) {
        debugPrint("Bad request: ${e.message}");
        return RegisterResult(resultStatus: AuthResultStatus.badRequest);
      }
      if (e is AuthException) {
        return RegisterResult(resultStatus: AuthResultStatus.wrongCredentials);
      }
      throw NetworkException(message: e.toString());
    });
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecotrip/data/network/constants/endpoints.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/data/network/exceptions/network_exceptions.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/auth/auth.dart';
import 'package:ecotrip/models/user/register_result.dart';
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

enum DocumentType { dni, goodBehaviourCertificate }

class PreSignedResult {
  final String url;
  final String key;

  PreSignedResult({required this.url, required this.key});
}

class RegisterApi {
  final RestClient _restClient;
  final Repository _repository;

  RegisterApi(this._restClient, this._repository);

  Future<PreSignedResult> getPresignedURL(DocumentType type) {
    return _repository.authToken.then((token) {
      return _restClient.post(
        Endpoints.getPresignedURL,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: {"document_type": type.name},
      ).then((dynamic res) {
        return PreSignedResult(url: res["url"], key: res["key"]);
      }).catchError((e) {
        throw NetworkException(message: e.toString());
      });
    });
  }

  Future<bool> uploadDocument(String url, File file) {
    return _restClient
        .put(
      url,
      headers: {
        "Content-Type": "application/octet-stream",
      },
      body: file.readAsBytesSync(),
    )
        .then((dynamic res) {
      return true;
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

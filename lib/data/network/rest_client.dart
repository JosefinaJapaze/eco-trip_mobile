import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:ecotrip/data/network/constants/endpoints.dart';
import 'package:ecotrip/data/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'exceptions/network_exceptions.dart';

class RestClient {
  final DioClient _dioClient = dioClient();

  Future<dynamic> get(String path,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    dynamic value;
    try {
      value = _dioClient.get(path,
          options: Options(responseType: ResponseType.json, headers: headers),
          queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleDioErr(e);
    }
    return value;
  }

  Future<dynamic> post(String path,
      {Map<String, String>? headers, body, encoding}) {
    dynamic value;
    try {
      value =
          _dioClient.post(path, data: body, options: Options(headers: headers));
    } on DioException catch (e) {
      _handleDioErr(e);
    }
    return value;
  }

  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, encoding}) {
    dynamic value;
    try {
      value =
          _dioClient.put(path, data: body, options: Options(headers: headers));
    } on DioException catch (e) {
      _handleDioErr(e);
    }
    return value;
  }

  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, encoding}) {
    dynamic value;
    try {
      value = _dioClient.delete(path, data: body);
    } on DioException catch (e) {
      _handleDioErr(e);
    }
    return value;
  }

  _handleDioErr(DioException e) {
    final statusCode = e.response?.statusCode;
    if (statusCode == null) {
      throw NetworkException(
          message: 'Error fetching data from server', statusCode: 500);
    }

    if (statusCode == 401) {
      throw AuthException(message: 'Unauthorized', statusCode: 401);
    }

    if (statusCode == 403) {
      throw AuthException(message: 'Forbidden', statusCode: 403);
    }

    if (statusCode == 400) {
      final message = e.response?.data['message'] ?? 'No message';
      throw BadRequestException(
          message: 'Bad request: ' + message, statusCode: 400);
    }

    if (statusCode > 400 || statusCode < 200) {
      throw NetworkException(
          message: 'Error fetching data from server',
          statusCode: e.response?.statusCode);
    }

    throw NetworkException(
        message: 'Error fetching data from server',
        statusCode: e.response?.statusCode);
  }

  static DioClient dioClient() {
    final client = Dio();
    client.options.baseUrl = Endpoints.host + Endpoints.baseUrl;
    client.options.headers = {
      'X-App-Version': '1.5.0',
    };

    if (dotenv.env['ENV'] == 'dev') {
      (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
        return client;
      };
    }

    return DioClient(client);
  }
}

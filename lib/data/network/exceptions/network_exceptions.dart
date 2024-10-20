class NetworkException implements Exception {
  String? message;
  int? statusCode;

  NetworkException({this.message, this.statusCode});
}

class AuthException extends NetworkException {
  AuthException({message, statusCode})
      : super(message: message, statusCode: statusCode);
}

class BadRequestException extends NetworkException {
  BadRequestException({message, statusCode})
      : super(message: message, statusCode: statusCode);
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  Endpoints._();

  static String host = envMustExist("BACKEND_URL");
  static const String baseUrl = "/api";
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 30000;

  static const String login = "/login";
  static const String trips = "/trips";
  static const String tripsJoin = "/trips/join";
  static const String myTrips = "/my-trips";
  static const String tripsNearby = "/trips/nearby";
  static const String register = "/register";
  static const String getPresignedURL = "/submissions/generate-presigned-url";
  static const String submitUserValidation = "/submissions";
  static const String myChats = "/my-chats";
  static const String messages = "/chats/messages";
}

String envMustExist(String key) {
  final env = dotenv.env[key];
  if (env == null) {
    throw Exception("BACKEND_URL must be defined in .env file");
  }
  return env;
}

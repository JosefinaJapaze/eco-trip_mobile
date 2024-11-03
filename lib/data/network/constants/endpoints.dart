class Endpoints {
  Endpoints._();

  static const String host = "https://rpi/";
  static const String baseUrl = "ecotrip/api";
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 30000;

  static const String login = "/login";
  static const String getTrips = "/trips";
  static const String register = "/register";
  static const String getPresignedURL = "/submissions/generate-presigned-url";
  static const String submitUserValidation = "/submissions";
}

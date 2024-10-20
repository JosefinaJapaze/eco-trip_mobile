class Endpoints {
  Endpoints._();

  static const String host = "192.168.2.44:8080";
  static const String baseUrl = "/api";
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 30000;

  static const String login = baseUrl + "/login";
  static const String getTrips = baseUrl + "/trips";
  static const String register = baseUrl + "/register";
  static const String getPresignedURL = baseUrl + "/submissions/generate-presigned-url";
}
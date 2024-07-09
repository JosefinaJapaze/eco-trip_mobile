class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;
  // connectTimeout
  static const int connectionTimeout = 30000;

  static const String login = baseUrl + "/login";
  static const String register = baseUrl + "/register";

  static const String getTrips = baseUrl + "/trips";
}
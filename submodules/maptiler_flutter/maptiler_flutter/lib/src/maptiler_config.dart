class MapTilerConfig {
  static final String baseUrl = 'api.maptiler.com';
  static String? _apiKey;

  static void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  static String get apiKey {
    if (_apiKey == null) {
      throw Exception(
          'API key is not set. Please set the API key before using the services.');
    }
    return _apiKey!;
  }
}

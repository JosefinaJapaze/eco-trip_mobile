import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../maptiler_config.dart';
import 'models.dart';

// https://docs.maptiler.com/cloud/api/geolocation/
class GeolocationAPI {
  const GeolocationAPI();

  Future<GeolocationResult> getIPGeolocation() async {
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/geolocation/ip.json?key=${MapTilerConfig.apiKey}');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return GeolocationResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load geolocation data. response.statusCode:${response.statusCode}');
    }
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maptiler_flutter/maptiler_flutter.dart';

class MaptilerClient {
  MaptilerClient._();

  static final MaptilerClient _instance = () {
    MapTilerConfig.setApiKey(dotenv.env['MAPTILER_API_KEY']!);
    return MaptilerClient._();
  }();

  static MaptilerClient get instance => _instance;

  Future<SearchResults> searchByCoordinates(double latitude, double longitude) async {
    return MapTiler.geocodingAPI.searchByCoordinates(longitude: longitude, latitude: latitude);
  }
}

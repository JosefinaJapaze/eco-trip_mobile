import 'services/geocoding/geocoding_api.dart';
import 'services/geolocation/geolocation_api.dart';
import 'services/coordinates/coordinates_api.dart';

class MapTiler {
  static GeocodingAPI geocodingAPI = const GeocodingAPI();
  static GeolocationAPI geolocationAPI = const GeolocationAPI();
  static CoordinatesAPI coordinatesAPI = const CoordinatesAPI();
}

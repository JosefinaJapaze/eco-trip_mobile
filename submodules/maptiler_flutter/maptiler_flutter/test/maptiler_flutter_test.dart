import 'package:maptiler_flutter/maptiler_flutter.dart';
import 'package:test/test.dart';
import 'api_key.dart';

void main() {
  group('CoordinatesAPI', () {
    setUp(() {
      MapTilerConfig.setApiKey(apiKey);
    });

    test('searchCoordinates', () async {
      final res = await MapTiler.coordinatesAPI.searchCoordinates("new york");
      expect(res.results.isNotEmpty, isTrue);
    });
  });
  group('GeolocationAPI', () {
    setUp(() {
      MapTilerConfig.setApiKey(apiKey);
    });

    test('getIPGeolocation', () async {
      final res = await MapTiler.geolocationAPI.getIPGeolocation();
      expect(res.city.isNotEmpty, isTrue);
    });
  });
  group('GeocodingAPI', () {
    setUp(() {
      MapTilerConfig.setApiKey(apiKey);
    });

    test('searchByName', () async {
      final res = await MapTiler.geocodingAPI.searchByName("new york");
      expect(res.features.isNotEmpty, isTrue);
    });
    test('searchByCoordinates', () async {
      final res = await MapTiler.geocodingAPI.searchByCoordinates(
          longitude: -4.4285085, latitude: 36.72130290415578);
      expect(res.features.isNotEmpty, isTrue);
    });
    test('searchByCoordinates 2', () async {
      final res = await MapTiler.geocodingAPI.searchByCoordinates(
          longitude: -4.421636648476124,
          latitude: 36.72130290415578,
          limit: 1,
          excludeTypes: true,
          types: ["country", "region", "subregion", "municipality"]);
      //-4.421636648476124%2C36.72130290415578&limit=10&types=country%2Cregion%2Csubregion%2Cmunicipality&excludeTypes=true&autocomplete=true
      expect(res.features.isNotEmpty, isTrue);
    });
  });
}

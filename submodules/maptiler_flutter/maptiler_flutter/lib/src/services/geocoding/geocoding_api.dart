import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../maptiler_config.dart';
import 'models.dart';

// https://docs.maptiler.com/cloud/api/geocoding
class GeocodingAPI {
  const GeocodingAPI();

  /// searchByName
  /// [query] Place name to search. You can also use bare POI category or mix it with a name to search for POIs of desired category, unless poi index is excluded.
  Future<SearchResults> searchByName(String query,
      {List<double>? bbox,
      Proximity? proximity, // Use ProximityLoc here
      List<String>? language,
      List<String>? country,
      int? limit,
      List<String>? types,
      bool? excludeTypes,
      bool? fuzzyMatch,
      bool? autocomplete}) async {
    if (query.isEmpty) {
      throw Exception('searchByName query is empty!');
    }
    var queryParams = {
      'bbox': bbox?.join(','),
      'proximity': proximity?.toString(), // Updated to use ProximityLoc
      'language': language?.join(','),
      'country': country?.join(','),
      'limit': limit?.toString(),
      'types': types?.join(','),
      'excludeTypes': excludeTypes?.toString(),
      'fuzzyMatch': fuzzyMatch?.toString(),
      'autocomplete': autocomplete?.toString(),
    }..removeWhere((key, value) => value == null);

    var queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/geocoding/$query.json?key=${MapTilerConfig.apiKey}&$queryString');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SearchResults.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search results. response.statusCode:${response.statusCode}');
    }
  }

  Future<SearchResults> searchByCoordinates(
      {required double longitude,
      required double latitude,
      List<String>? language,
      int? limit,
      List<String>? types,
      bool? excludeTypes}) async {
    var queryParams = {
      'language': language?.join(','),
      'limit': limit?.toString(),
      'types': types?.join(','),
      'excludeTypes': excludeTypes?.toString(),
    }..removeWhere((key, value) => value == null);

    var queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/geocoding/$longitude,$latitude.json?key=${MapTilerConfig.apiKey}&$queryString');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SearchResults.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search results. response.statusCode:${response.statusCode}');
    }
  }

  Future<SearchResults> searchByFeatureId(String featureId,
      {List<String>? language}) async {
    var queryParams = {
      'language': language?.join(','),
    }..removeWhere((key, value) => value == null);

    var queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/geocoding/$featureId.json?key=${MapTilerConfig.apiKey}&$queryString');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SearchResults.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search results. response.statusCode:${response.statusCode}');
    }
  }

  Future<List<SearchResults>> batchGeocoding(List<String> queries,
      {List<double>? bbox,
      String? proximity,
      List<String>? language,
      List<String>? country,
      int? limit,
      List<String>? types,
      bool? excludeTypes,
      bool? fuzzyMatch,
      bool? autocomplete}) async {
    queries = queries..removeWhere((value) => value == "");
    if (queries.isEmpty) {
      throw Exception('batchGeocoding queries were empty.');
    }
    var queryParams = {
      'bbox': bbox?.join(','),
      'proximity': proximity,
      'language': language?.join(','),
      'country': country?.join(','),
      'limit': limit?.toString(),
      'types': types?.join(','),
      'excludeTypes': excludeTypes?.toString(),
      'fuzzyMatch': fuzzyMatch?.toString(),
      'autocomplete': autocomplete?.toString(),
    }..removeWhere((key, value) => value == null);

    var queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/geocoding/${queries.join(';')}.json?key=${MapTilerConfig.apiKey}&$queryString');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      return data.map((item) => SearchResults.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load batch search results. response.statusCode:${response.statusCode}');
    }
  }
}

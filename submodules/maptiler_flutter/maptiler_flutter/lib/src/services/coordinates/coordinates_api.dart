import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../maptiler_config.dart';
import 'models.dart';

// https://docs.maptiler.com/cloud/api/coordinates/
class CoordinatesAPI {
  const CoordinatesAPI();

  Future<SearchResult> searchCoordinates(String query,
      {int? limit, bool? transformations, bool? exports}) async {
    var queryParams = {
      'limit': limit?.toString(),
      'transformations': transformations?.toString(),
      'exports': exports?.toString(),
    }..removeWhere((key, value) => value == null);

    var queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/coordinates/search/$query.json?key=${MapTilerConfig.apiKey}&$queryString');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load search results. response.statusCode:${response.statusCode}');
    }
  }

  Future<TransformResult> transformCoordinates(String coordinates,
      {int s_srs = 4326, int t_srs = 4326, String ops = ""}) async {
    var url = Uri.parse(
        'https://${MapTilerConfig.baseUrl}/coordinates/transform/$coordinates.json?key=${MapTilerConfig.apiKey}&s_srs=$s_srs&t_srs=$t_srs&ops=$ops');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return TransformResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to transform coordinates. response.statusCode:${response.statusCode}');
    }
  }
}

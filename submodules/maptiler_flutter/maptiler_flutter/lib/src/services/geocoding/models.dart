/// https://docs.maptiler.com/cloud/api/geocoding/#SearchResults
class SearchResults {
  final String type;
  final List<Feature> features;
  final dynamic query;
  final String attribution;

  SearchResults(
      {required this.type,
      required this.features,
      required this.query,
      required this.attribution});

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        type: json['type'],
        features: List<Feature>.from(
            json['features'].map((x) => Feature.fromJson(x))),
        query: json[
            'query'], // according to documentation it is a list of two doubles but api often returns a string
        // query: List<double>.from(json['query'].map((x) => x as double)),
        attribution: json['attribution'],
      );
}

class Feature {
  final String id;
  final String text;
  final String type;
  final FeatureProperties properties;
  final dynamic geometry; // This could be PointObject, LineStringObject, etc.
  final BoundingBox bbox;
  final Coordinates center;
  final String? placeName;
  final List<String> placeType;
  final double relevance;
  final List<ContextObject>? context;
  final String? address;

  Feature({
    required this.id,
    required this.text,
    required this.type,
    required this.properties,
    required this.geometry,
    required this.bbox,
    required this.center,
    required this.placeName,
    required this.placeType,
    required this.relevance,
    required this.context,
    required this.address,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        properties: FeatureProperties.fromJson(json['properties']),
        geometry: json[
            'geometry'], // You need to handle different geometry types here
        bbox: BoundingBox.fromJson(json['bbox']),
        center: Coordinates.fromJson(json['center']),
        placeName: json['place_name'],
        placeType:
            List<String>.from(json['place_type'].map((x) => x as String)),
        relevance: json['relevance'].toDouble(),
        context: json['context'] != null
            ? List<ContextObject>.from(
                json['context'].map((x) => ContextObject.fromJson(x)))
            : null,
        address: json['address'],
      );
}

class FeatureProperties {
  final String ref;
  final String? country_code;
  final String? kind;
  final List<String>? categories;
  final OSMTagsObject? osmTags;
  final String? osmPlaceType;
  final String? name;

  FeatureProperties({
    required this.ref,
    required this.country_code,
    required this.kind,
    required this.categories,
    required this.osmTags,
    required this.osmPlaceType,
    this.name,
  });

  factory FeatureProperties.fromJson(Map<String, dynamic> json) =>
      FeatureProperties(
        ref: json['ref'],
        country_code: json['country_code'],
        kind: json['kind'],
        categories: json['categories'] != null
            ? List<String>.from(json['categories'].map((x) => x as String))
            : [],
        osmTags: json['osm:tags'] != null
            ? OSMTagsObject.fromJson(json['osm:tags'])
            : null,
        osmPlaceType: json['osm:place_type'],
        name: json['name'],
      );
}

class Point {
  final String type;
  final Coordinates coordinates;

  Point({required this.type, required this.coordinates});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      type: json['type'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates.toJson(),
      };
}

class LineString {
  final String type;
  final List<Coordinates> coordinates;

  LineString({required this.type, required this.coordinates});

  factory LineString.fromJson(Map<String, dynamic> json) {
    return LineString(
      type: json['type'],
      coordinates: List<Coordinates>.from(
          json['coordinates'].map((x) => Coordinates.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates.map((x) => x.toJson()).toList(),
      };
}

class Polygon {
  final String type;
  final List<List<Coordinates>> coordinates;

  Polygon({required this.type, required this.coordinates});

  factory Polygon.fromJson(Map<String, dynamic> json) {
    return Polygon(
      type: json['type'],
      coordinates: List<List<Coordinates>>.from(json['coordinates'].map((x) =>
          List<Coordinates>.from(x.map((y) => Coordinates.fromJson(y))))),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates':
            coordinates.map((x) => x.map((y) => y.toJson()).toList()).toList(),
      };
}

class MultiPoint {
  final String type;
  final List<Coordinates> coordinates;

  MultiPoint({required this.type, required this.coordinates});

  factory MultiPoint.fromJson(Map<String, dynamic> json) {
    return MultiPoint(
      type: json['type'],
      coordinates: List<Coordinates>.from(
          json['coordinates'].map((x) => Coordinates.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates.map((x) => x.toJson()).toList(),
      };
}

class MultiLineString {
  final String type;
  final List<List<Coordinates>> coordinates;

  MultiLineString({required this.type, required this.coordinates});

  factory MultiLineString.fromJson(Map<String, dynamic> json) {
    return MultiLineString(
      type: json['type'],
      coordinates: List<List<Coordinates>>.from(json['coordinates'].map((x) =>
          List<Coordinates>.from(x.map((y) => Coordinates.fromJson(y))))),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates':
            coordinates.map((x) => x.map((y) => y.toJson()).toList()).toList(),
      };
}

class MultiPolygon {
  final String type;
  final List<List<List<Coordinates>>> coordinates;

  MultiPolygon({required this.type, required this.coordinates});

  factory MultiPolygon.fromJson(Map<String, dynamic> json) {
    return MultiPolygon(
      type: json['type'],
      coordinates: List<List<List<Coordinates>>>.from(json['coordinates'].map(
          (x) => List<List<Coordinates>>.from(x.map((y) =>
              List<Coordinates>.from(y.map((z) => Coordinates.fromJson(z))))))),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates
            .map(
                (x) => x.map((y) => y.map((z) => z.toJson()).toList()).toList())
            .toList(),
      };
}

class GeometryCollection {
  final String type;
  final List<dynamic> geometries; // This could include any of the above types.

  GeometryCollection({required this.type, required this.geometries});

  factory GeometryCollection.fromJson(Map<String, dynamic> json) {
    // You need to implement the logic to parse different geometry types
    return GeometryCollection(
      type: json['type'],
      geometries: json['geometries'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'geometries':
            geometries, // Implement serialization for different geometries
      };
}

class BoundingBox {
  final double west;
  final double south;
  final double east;
  final double north;

  BoundingBox(
      {required this.west,
      required this.south,
      required this.east,
      required this.north});

  factory BoundingBox.fromJson(List<dynamic> json) => BoundingBox(
        west: json[0].toDouble(),
        south: json[1].toDouble(),
        east: json[2].toDouble(),
        north: json[3].toDouble(),
      );
}

class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({required this.longitude, required this.latitude});

  factory Coordinates.fromJson(List<dynamic> json) => Coordinates(
        longitude: json[0].toDouble(),
        latitude: json[1].toDouble(),
      );

  List<double> toJson() => [longitude, latitude];
}

class ContextObject {
  final String id;
  final String text;
  final String? language;
  final String? type;
  final Map<String, String> languageTexts; // Assuming multiple language texts

  ContextObject({
    required this.id,
    required this.text,
    required this.language,
    required this.type,
    required this.languageTexts,
  });

  factory ContextObject.fromJson(Map<String, dynamic> json) {
    // Parsing language-specific texts
    Map<String, String> languageTexts = {};
    json.forEach((key, value) {
      if (key.startsWith('^text_')) {
        languageTexts[key] = value;
      }
    });

    return ContextObject(
      id: json['id'],
      text: json['text'],
      language: json['language'],
      type: json['type'],
      languageTexts: languageTexts,
    );
  }
}

class OSMTagsObject {
  // (experimental) Feature tags from OpenStreetMap. Only available for poi type.
  final String name;
  // final String amenity;
  // final String highway;

  OSMTagsObject({
    required this.name,
    // required this.amenity,
    // required this.highway,
  });

  factory OSMTagsObject.fromJson(Map<String, dynamic> json) => OSMTagsObject(
        name: json['name'] ?? '',
        // amenity: json['amenity'] ?? '',
        // highway: json['highway'] ?? '',
      );
}

// Define other geometrical types like PointObject, LineStringObject, etc.

// custom Helper class not defined in the API itself
class Proximity {
  final double latitude;
  final double longitude;

  Proximity({required this.latitude, required this.longitude});

  @override
  String toString() {
    return '$longitude,$latitude';
  }
}

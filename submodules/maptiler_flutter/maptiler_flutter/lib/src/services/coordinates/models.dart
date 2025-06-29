class SearchResult {
  final List<SearchItem> results;
  final int total;

  SearchResult({required this.results, required this.total});

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        results: List<SearchItem>.from(
            json["results"].map((x) => SearchItem.fromJson(x))),
        total: json["total"],
      );
}

class SearchItem {
  final double? accuracy;
  final String? area;
  final List<double>? bbox;
  final DefaultTransformation? defaultTransformation;
  final bool? deprecated;
  final ExportItem? exports;
  final Id? id;
  final String? kind;
  final String? name;
  final List<dynamic>? transformations; // Type may vary, so dynamic is used
  final String? unit;

  SearchItem({
    this.accuracy,
    this.area,
    this.bbox,
    this.defaultTransformation,
    this.deprecated,
    this.exports,
    this.id,
    this.kind,
    this.name,
    this.transformations,
    this.unit,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
        accuracy: json['accuracy'],
        area: json['area'],
        bbox: json['bbox']?.cast<double>(),
        defaultTransformation: json['default_transformation'] != null
            ? DefaultTransformation.fromJson(json['default_transformation'])
            : null,
        deprecated: json['deprecated'],
        exports: json['exports'] != null
            ? ExportItem.fromJson(json['exports'])
            : null,
        id: json['id'] != null ? Id.fromJson(json['id']) : null,
        kind: json['kind'],
        name: json['name'],
        transformations: json['transformations'],
        unit: json['unit'],
      );
}

class DefaultTransformation {
  final String? authority;
  final int? code;

  DefaultTransformation({this.authority, this.code});

  factory DefaultTransformation.fromJson(Map<String, dynamic> json) =>
      DefaultTransformation(
        authority: json['authority'],
        code: json['code'],
      );
}

class ExportItem {
  final String? proj4;
  final String? wkt;

  ExportItem({this.proj4, this.wkt});

  factory ExportItem.fromJson(Map<String, dynamic> json) => ExportItem(
        proj4: json['proj4'],
        wkt: json['wkt'],
      );
}

class Id {
  final String? authority;
  final int? code;

  Id({this.authority, this.code});

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        authority: json['authority'],
        code: json['code'],
      );
}

class TransformResult {
  final List<XYZ> results;
  final String transformerSelectionStrategy;

  TransformResult(
      {required this.results, required this.transformerSelectionStrategy});

  factory TransformResult.fromJson(Map<String, dynamic> json) =>
      TransformResult(
        results: List<XYZ>.from(json["results"].map((x) => XYZ.fromJson(x))),
        transformerSelectionStrategy: json["transformer_selection_strategy"],
      );
}

class XYZ {
  final double x;
  final double y;
  final double z;

  XYZ({required this.x, required this.y, required this.z});

  factory XYZ.fromJson(Map<String, dynamic> json) => XYZ(
        x: json["x"],
        y: json["y"],
        z: json["z"],
      );
}

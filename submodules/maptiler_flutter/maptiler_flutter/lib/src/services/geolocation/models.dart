class GeolocationResult {
  final String country;
  final String country_code;
  final List<double> country_bounds;
  final List<String> country_languages;
  final String continent;
  final String continent_code;
  final bool eu;
  final String city;
  final double latitude;
  final double longitude;
  final String postal;
  final String region;
  final String region_code;
  final String timezone;

  GeolocationResult({
    required this.country,
    required this.country_code,
    required this.country_bounds,
    required this.country_languages,
    required this.continent,
    required this.continent_code,
    required this.eu,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.postal,
    required this.region,
    required this.region_code,
    required this.timezone,
  });

  factory GeolocationResult.fromJson(Map<String, dynamic> json) {
    return GeolocationResult(
      country: json['country'],
      country_code: json['country_code'],
      country_bounds:
          List<double>.from(json['country_bounds'].map((x) => x.toDouble())),
      country_languages:
          List<String>.from(json['country_languages'].map((x) => x as String)),
      continent: json['continent'],
      continent_code: json['continent_code'],
      eu: json['eu'],
      city: json['city'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      postal: json['postal'],
      region: json['region'],
      region_code: json['region_code'],
      timezone: json['timezone'],
    );
  }
}

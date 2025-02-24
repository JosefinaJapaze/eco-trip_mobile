class Address {
  String? address;
  double? latitude;
  double? longitude;

  Address({
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}

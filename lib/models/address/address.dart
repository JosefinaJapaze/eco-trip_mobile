class Address {
  String? address;
  String? city;
  String? state;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.country,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "city": city,
        "state": state,
        "country": country,
      };
}

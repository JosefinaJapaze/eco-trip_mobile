import '../address/address.dart';

enum DayOfWeek {
  LUNES,
  MARTES,
  MIERCOLES,
  JUEVES,
  VIERNES,
  SABADO,
  DOMINGO,
}

class FrequentTripParams {
  DayOfWeek? dayOfWeek;
  int? startTime;

  FrequentTripParams({
    this.dayOfWeek,
    this.startTime,
  });

  factory FrequentTripParams.fromMap(Map<String, dynamic> json) => FrequentTripParams(
    dayOfWeek: DayOfWeek.values.firstWhere((e) => e.toString() == json["day_of_week"]),
    startTime: json["start_time"],
  );

  Map<String, dynamic> toMap() => {
    "day_of_week": dayOfWeek?.name.toLowerCase(),
    "start_time": startTime,
  };
}

class ScheduledTripParams {
  DateTime? startDate;
  int? startTime;

  ScheduledTripParams({
    this.startDate,
    this.startTime,
  });

  factory ScheduledTripParams.fromMap(Map<String, dynamic> json) => ScheduledTripParams(
    startDate: json["start_date"],
    startTime: json["start_time"],
  );

  Map<String, dynamic> toMap() => {
    "start_date": startDate != null ? startDate!.toIso8601String() + "Z" : null,
    "start_time": startTime,
  };
}

class Trip {
  int? id;
  int? totalSeats;
  String? type;
  double? cost;
  Address? addressFrom;
  Address? addressTo;
  FrequentTripParams? frequentTripParams;
  ScheduledTripParams? scheduledTripParams;

  Trip({
    this.id,
    this.totalSeats,
    this.type,
    this.cost,
    this.addressFrom,
    this.addressTo,
    this.frequentTripParams,
    this.scheduledTripParams,
  });

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
    id: json["id"],
    totalSeats: json["total_seats"],
    type: json["type"],
    cost: json["cost"],
    addressFrom: Address(
      address: json["address_from_address"],
      city: json["address_from_city"],
    ),
    addressTo: Address(
      address: json["address_to_address"],
      city: json["address_to_city"],
    ),
    frequentTripParams: FrequentTripParams(
      dayOfWeek: DayOfWeek.values.firstWhere((e) => e.toString() == json["day_of_week"]),
      startTime: json["start_time"],
    ),
    scheduledTripParams: ScheduledTripParams(
      startDate: json["start_date"],
      startTime: json["start_time"],
    ),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "total_seats": totalSeats,
    "type": type,
    "cost": cost,
    "address_from": addressFrom?.toMap(),
    "address_to": addressTo?.toMap(),
    "frequentTripParams": frequentTripParams?.toMap(),
    "scheduledTripParams": scheduledTripParams?.toMap(),
  };
}

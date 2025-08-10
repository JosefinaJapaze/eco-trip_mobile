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
  String? creator;
  Address? addressFrom;
  Address? addressTo;
  FrequentTripParams? frequentTripParams;
  ScheduledTripParams? scheduledTripParams;

  Trip({
    this.id,
    this.totalSeats,
    this.type,
    this.cost,
    this.creator,
    this.addressFrom,
    this.addressTo,
    this.frequentTripParams,
    this.scheduledTripParams,
  });

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
    id: json["TripID"],
    totalSeats: json["TotalSeats"],
    type: json["Type"],
    cost: json["Cost"] is int ? (json["Cost"] as int).toDouble() : json["Cost"],
    creator: json["Creator"],
    addressFrom: Address(
      address: json["FromAddress"],
      latitude: json["FromLat"],
      longitude: json["FromLon"],
    ),
    addressTo: Address(
      address: json["ToAddress"],
      latitude: json["ToLat"],
      longitude: json["ToLon"],
    ),
    frequentTripParams: FrequentTripParams(
      dayOfWeek: json["DayOfWeek"] != null && json["DayOfWeek"] != ""
          ? DayOfWeek.values.firstWhere(
              (e) => e.name.toLowerCase() == json["DayOfWeek"].toLowerCase(),
              orElse: () => DayOfWeek.LUNES,
            )
          : null,
      startTime: json["TimeOfDay"] is String && json["TimeOfDay"].isNotEmpty
          ? parseTimeOfDay(json["TimeOfDay"])
          : null,
    ),
    scheduledTripParams: ScheduledTripParams(
      startDate: json["StartDate"] != null ? DateTime.parse(json["StartDate"]) : null,
      startTime: json["TimeOfDay"] is String && json["TimeOfDay"].isNotEmpty
          ? parseTimeOfDay(json["TimeOfDay"])
          : null,
    ),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "total_seats": totalSeats,
    "type": type,
    "cost": cost,
    "creator": creator,
    "address_from": addressFrom?.toMap(),
    "address_to": addressTo?.toMap(),
    "frequentTripParams": frequentTripParams?.toMap(),
    "scheduledTripParams": scheduledTripParams?.toMap(),
  };
}

int parseTimeOfDay(String timeOfDay) {
  final parts = timeOfDay.split(":");
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);
  return hours * 100 + minutes;
}
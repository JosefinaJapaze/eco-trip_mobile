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

class Trip {
  int? id;
  DateTime? startDate;
  bool? isFinished;
  bool? hasStarted;
  int? totalSeats;
  String? type;
  double? cost;
  Address? addressFrom;
  Address? addressTo;
  String? userId;
  DayOfWeek? dayOfWeek;

  Trip({
    this.id,
    this.startDate,
    this.isFinished,
    this.hasStarted,
    this.totalSeats,
    this.type,
    this.cost,
    this.addressFrom,
    this.addressTo,
    this.userId,
    this.dayOfWeek,
  });

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
    id: json["id"],
    startDate: json["start_date"],
    isFinished: json["is_finished"],
    hasStarted: json["has_started"],
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
    userId: json["user_id"],
    dayOfWeek: DayOfWeek.values.firstWhere((e) => e.toString() == json["day_of_week"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "start_date": startDate,
    "is_finished": isFinished,
    "has_started": hasStarted,
    "total_seats": totalSeats,
    "type": type,
    "cost": cost,
    "address_from_address": addressFrom == null ? addressFrom?.address : "",
    "address_from_city": addressFrom == null ? addressFrom?.city : "",
    "address_to_address": addressTo == null ? addressTo?.address : "",
    "address_to_city": addressTo == null ? addressTo?.city : "",
    "user_id": userId,
    "day_of_week": dayOfWeek?.toString(),
  };
}

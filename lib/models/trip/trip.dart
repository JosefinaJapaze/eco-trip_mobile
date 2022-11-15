import '../address/address.dart';

class Trip {
  int? id;
  DateTime? startedOn;
  DateTime? finishedOn;
  bool? isFinished;
  bool? hasStarted;
  int? seatsLeft;
  String? type;
  double? cost;
  Address? addressFrom;
  Address? addressTo;
  String? userId;

  Trip({
    this.id,
    this.startedOn,
    this.finishedOn,
    this.isFinished,
    this.hasStarted,
    this.seatsLeft,
    this.type,
    this.cost,
    this.addressFrom,
    this.addressTo,
    this.userId,
  });

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
    id: json["id"],
    startedOn: json["startedOn"],
    finishedOn: json["finishedOn"],
    isFinished: json["isFinished"],
    hasStarted: json["hasStarted"],
    seatsLeft: json["seatsLeft"],
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
    userId: json["userId"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "startedOn": startedOn,
    "finishedOn": finishedOn,
    "isFinished": isFinished,
    "hasStarted": hasStarted,
    "seatsLeft": seatsLeft,
    "type": type,
    "cost": cost,
    "address_from_address": addressFrom == null ? addressFrom?.address : "",
    "address_from_city": addressFrom == null ? addressFrom?.city : "",
    "address_to_address": addressTo == null ? addressTo?.address : "",
    "address_to_city": addressTo == null ? addressTo?.city : "",
    "userId": userId,
  };
}

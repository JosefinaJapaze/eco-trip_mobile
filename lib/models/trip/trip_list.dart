import 'package:ecotrip/models/trip/trip.dart';

class TripList {
  final List<Trip>? trips;

  TripList({
    this.trips,
  });

  factory TripList.fromJson(List<dynamic> json) {
    List<Trip> trips = <Trip>[];
    trips = json.map((trip) => Trip.fromMap(trip)).toList();

    return TripList(
      trips: trips,
    );
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecotrip/data/network/constants/endpoints.dart';
import 'package:ecotrip/data/network/exceptions/network_exceptions.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/models/trip/trip_list.dart';

class CreateTripAddress {
  final String address;
  final double latitude;
  final double longitude;

  CreateTripAddress({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

class CreateTripParams {
  final CreateTripAddress origin;
  final CreateTripAddress destination;
  final int totalSeats;
  final String type;
  final double cost;
  final FrequentTripParams? frequentTripParams;
  final ScheduledTripParams? scheduledTripParams;

  CreateTripParams({
    required this.origin,
    required this.destination,
    required this.totalSeats,
    required this.type,
    required this.cost,
    this.frequentTripParams,
    this.scheduledTripParams,
  });

  Map<String, dynamic> toJson() {
    return {
      "address_from": {
        "address": origin.address,
        "latitude": origin.latitude,
        "longitude": origin.longitude,
      },
      "address_to": {
        "address": destination.address,
        "latitude": destination.latitude,
        "longitude": destination.longitude,
      },
      "total_seats": totalSeats,
      "type": type,
      "cost": cost,
      if (frequentTripParams != null) "frequentTripParams": frequentTripParams!.toMap(),
      if (scheduledTripParams != null) "scheduledTripParams": scheduledTripParams!.toMap(),
    };
  }
}

class TripApi {
  final RestClient _restClient;
  final Repository _repository;

  TripApi(this._restClient, this._repository);

  Future<TripList> getTrips() async {
    return TripList();
  }

  Future<bool> insertTrip(CreateTripParams params) async {
    return _repository.authToken.then((token) {
      return _restClient
          .post(Endpoints.trips,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token",
              },
              body: params.toJson())
          .then((dynamic res) {
        return true;
      }).catchError((e) {
        if (e is DioException) {
          print("Dio exception: ${e.message}; ${e.response}");
        }
        throw NetworkException(message: e.toString());
      });
    });
  }
}

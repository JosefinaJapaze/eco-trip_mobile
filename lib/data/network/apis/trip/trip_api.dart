import 'dart:async';

import 'package:ecotrip/data/network/dio_client.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/models/trip/trip_list.dart';

class TripApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  TripApi(this._dioClient, this._restClient);

  /// Returns list of trip in response
  Future<TripList> getTrips() async {
    return TripList();
  }

  /// sample api call with default rest client
//  Future<TripsList> getTrips() {
//
//    return _restClient
//        .get(Endpoints.getTrips)
//        .then((dynamic res) => TripsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}

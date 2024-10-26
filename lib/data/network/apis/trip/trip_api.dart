import 'dart:async';

import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/models/trip/trip_list.dart';

class TripApi {
  final RestClient _restClient;

  // injecting dio instance
  TripApi(this._restClient);

  /// Returns list of trip in response
  Future<TripList> getTrips() async {
    return TripList();
  }
}

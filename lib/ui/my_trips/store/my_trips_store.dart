import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'my_trips_store.g.dart';

class MyTripsStore = _MyTripsStore with _$MyTripsStore;

abstract class _MyTripsStore with Store {
  final TripApi _tripApi;
  final ErrorStore errorStore = ErrorStore();

  _MyTripsStore(TripApi api) : this._tripApi = api;

  static ObservableFuture<List<Trip>> emptyTripsResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Trip>> tripsFuture = emptyTripsResponse;

  @computed
  bool get isLoading => tripsFuture.status == FutureStatus.pending;

  @action
  Future<void> fetchTrips() async {
    final future = _tripApi.getMyTrips();
    tripsFuture = ObservableFuture(future);

    future.catchError((error) {
      errorStore.errorMessage = error.toString();
    });
  }
} 
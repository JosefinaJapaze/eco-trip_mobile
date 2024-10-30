import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../models/trip/trip.dart';
import '../../models/trip/trip_list.dart';

part 'trip_store.g.dart';

class TripStore = _TripStore with _$TripStore;

abstract class _TripStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _TripStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<TripList?> emptyTripResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<TripList?> fetchTripsFuture =
      ObservableFuture<TripList?>(emptyTripResponse);

  @observable
  TripList? tripList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchTripsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getTrips() async {
    // final future = _repository.getTrips();
    // fetchTripsFuture = ObservableFuture(future);

    // future.then((tripList) {
    //   this.tripList = tripList;
    // }).catchError((error) {
    //   errorStore.errorMessage = "Couldn't fetch trips. Please try again later.";
    // });
  }

  @action
  Future insertTrip(Trip trip) async {
    // _repository.insert(trip);

    // final future = _repository.getTrips();
    // fetchTripsFuture = ObservableFuture(future);

    // future.then((tripList) {
    //   this.tripList = tripList;
    // }).catchError((error) {
    //   errorStore.errorMessage = "Couldn't fetch trips. Please try again later.";
    // });
  }
}

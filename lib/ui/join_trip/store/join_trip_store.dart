import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/models/trip/trip.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'join_trip_store.g.dart';

class JoinTripStore = _JoinTripStore with _$JoinTripStore;

abstract class _JoinTripStore with Store {
  final TripApi _tripApi;
  final ErrorStore errorStore = ErrorStore();

  _JoinTripStore(TripApi api) : this._tripApi = api {
    _setupDisposers();
  }

  @observable
  bool success = false;

  @observable
  ObservableFuture<bool> response = ObservableFuture.value(false);

  @computed
  bool get isLoading =>
      response.status == FutureStatus.pending ||
      joinTripFuture.status == FutureStatus.pending ||
      nearbyTripsFuture.status == FutureStatus.pending;

  @action
  void setSuccess(bool value) {
    success = value;
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  static ObservableFuture<bool> emptyJoinResponse =
      ObservableFuture.value(false);

  static ObservableFuture<List<Trip>> emptyNearbyTripsResponse =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<bool> joinTripFuture = emptyJoinResponse;

  @observable
  ObservableFuture<List<Trip>> nearbyTripsFuture = emptyNearbyTripsResponse;

  // Store last fetch parameters for re-fetching
  double? _lastLatitude;
  double? _lastLongitude;
  String? _lastType;

  @action
  Future joinTrip(String tripId) async {
    final future = _tripApi.joinTrip(tripId);
    joinTripFuture = ObservableFuture(future);
    try {
      bool joined = await future;
      if (joined) {
        this.success = true;
        // Re-fetch nearby trips after successful join
        if (_lastLatitude != null && _lastLongitude != null && _lastType != null) {
          await listNearbyTrips(_lastLatitude!, _lastLongitude!, _lastType!);
        }
      } else {
        this.success = false;
        errorStore.errorMessage = 'Error al unirse al viaje';
      }
      
    } catch (e) {
      this.success = false;
      errorStore.errorMessage = 'Error al unirse al viaje';
    }
  }

  @action
  void clearNearbyTrips() {
    nearbyTripsFuture = emptyNearbyTripsResponse;
    // Clear stored parameters to avoid re-fetching with wrong parameters
    _lastLatitude = null;
    _lastLongitude = null;
    _lastType = null;
  }

  @action
  Future<List<Trip>> listNearbyTrips(
      double latitude, double longitude, String type) async {
    // Store parameters for potential re-fetching
    _lastLatitude = latitude;
    _lastLongitude = longitude;
    _lastType = type;
    
    final future = _tripApi.listNearbyTrips(latitude, longitude, type);
    nearbyTripsFuture = ObservableFuture(future);
    try {
      List<Trip> trips = await future;
      return trips;
    } catch (e) {
      errorStore.errorMessage = 'Error al obtener viajes cercanos';
      return [];
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

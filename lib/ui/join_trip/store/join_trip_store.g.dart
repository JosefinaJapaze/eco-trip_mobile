// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_trip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$JoinTripStore on _JoinTripStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_JoinTripStore.isLoading'))
          .value;

  late final _$successAtom =
      Atom(name: '_JoinTripStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$responseAtom =
      Atom(name: '_JoinTripStore.response', context: context);

  @override
  ObservableFuture<bool> get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(ObservableFuture<bool> value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$joinTripFutureAtom =
      Atom(name: '_JoinTripStore.joinTripFuture', context: context);

  @override
  ObservableFuture<bool> get joinTripFuture {
    _$joinTripFutureAtom.reportRead();
    return super.joinTripFuture;
  }

  @override
  set joinTripFuture(ObservableFuture<bool> value) {
    _$joinTripFutureAtom.reportWrite(value, super.joinTripFuture, () {
      super.joinTripFuture = value;
    });
  }

  late final _$nearbyTripsFutureAtom =
      Atom(name: '_JoinTripStore.nearbyTripsFuture', context: context);

  @override
  ObservableFuture<List<Trip>> get nearbyTripsFuture {
    _$nearbyTripsFutureAtom.reportRead();
    return super.nearbyTripsFuture;
  }

  @override
  set nearbyTripsFuture(ObservableFuture<List<Trip>> value) {
    _$nearbyTripsFutureAtom.reportWrite(value, super.nearbyTripsFuture, () {
      super.nearbyTripsFuture = value;
    });
  }

  late final _$joinTripAsyncAction =
      AsyncAction('_JoinTripStore.joinTrip', context: context);

  @override
  Future<dynamic> joinTrip(String tripId) {
    return _$joinTripAsyncAction.run(() => super.joinTrip(tripId));
  }

  late final _$listNearbyTripsAsyncAction =
      AsyncAction('_JoinTripStore.listNearbyTrips', context: context);

  @override
  Future<dynamic> listNearbyTrips(double latitude, double longitude) {
    return _$listNearbyTripsAsyncAction
        .run(() => super.listNearbyTrips(latitude, longitude));
  }

  late final _$_JoinTripStoreActionController =
      ActionController(name: '_JoinTripStore', context: context);

  @override
  void setSuccess(bool value) {
    final _$actionInfo = _$_JoinTripStoreActionController.startAction(
        name: '_JoinTripStore.setSuccess');
    try {
      return super.setSuccess(value);
    } finally {
      _$_JoinTripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
response: ${response},
joinTripFuture: ${joinTripFuture},
nearbyTripsFuture: ${nearbyTripsFuture},
isLoading: ${isLoading}
    ''';
  }
}

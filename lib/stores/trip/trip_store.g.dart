// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TripStore on _TripStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_TripStore.loading'))
      .value;

  late final _$fetchTripsFutureAtom =
      Atom(name: '_TripStore.fetchTripsFuture', context: context);

  @override
  ObservableFuture<TripList?> get fetchTripsFuture {
    _$fetchTripsFutureAtom.reportRead();
    return super.fetchTripsFuture;
  }

  @override
  set fetchTripsFuture(ObservableFuture<TripList?> value) {
    _$fetchTripsFutureAtom.reportWrite(value, super.fetchTripsFuture, () {
      super.fetchTripsFuture = value;
    });
  }

  late final _$tripListAtom =
      Atom(name: '_TripStore.tripList', context: context);

  @override
  TripList? get tripList {
    _$tripListAtom.reportRead();
    return super.tripList;
  }

  @override
  set tripList(TripList? value) {
    _$tripListAtom.reportWrite(value, super.tripList, () {
      super.tripList = value;
    });
  }

  late final _$successAtom = Atom(name: '_TripStore.success', context: context);

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

  late final _$getTripsAsyncAction =
      AsyncAction('_TripStore.getTrips', context: context);

  @override
  Future<dynamic> getTrips() {
    return _$getTripsAsyncAction.run(() => super.getTrips());
  }

  late final _$insertTripAsyncAction =
      AsyncAction('_TripStore.insertTrip', context: context);

  @override
  Future<dynamic> insertTrip(Trip trip) {
    return _$insertTripAsyncAction.run(() => super.insertTrip(trip));
  }

  @override
  String toString() {
    return '''
fetchTripsFuture: ${fetchTripsFuture},
tripList: ${tripList},
success: ${success},
loading: ${loading}
    ''';
  }
}

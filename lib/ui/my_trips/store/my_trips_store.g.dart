// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_trips_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyTripsStore on _MyTripsStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_MyTripsStore.isLoading'))
          .value;

  late final _$tripsFutureAtom =
      Atom(name: '_MyTripsStore.tripsFuture', context: context);

  @override
  ObservableFuture<List<Trip>> get tripsFuture {
    _$tripsFutureAtom.reportRead();
    return super.tripsFuture;
  }

  @override
  set tripsFuture(ObservableFuture<List<Trip>> value) {
    _$tripsFutureAtom.reportWrite(value, super.tripsFuture, () {
      super.tripsFuture = value;
    });
  }

  late final _$fetchTripsAsyncAction =
      AsyncAction('_MyTripsStore.fetchTrips', context: context);

  @override
  Future<void> fetchTrips() {
    return _$fetchTripsAsyncAction.run(() => super.fetchTrips());
  }

  @override
  String toString() {
    return '''
tripsFuture: ${tripsFuture},
isLoading: ${isLoading}
    ''';
  }
}

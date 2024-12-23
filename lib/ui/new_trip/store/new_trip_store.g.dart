// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_trip_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewTripStore on _NewTripStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_NewTripStore.isLoading'))
          .value;

  late final _$successAtom =
      Atom(name: '_NewTripStore.success', context: context);

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
      Atom(name: '_NewTripStore.response', context: context);

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

  late final _$newTripFutureAtom =
      Atom(name: '_NewTripStore.newTripFuture', context: context);

  @override
  ObservableFuture<bool> get newTripFuture {
    _$newTripFutureAtom.reportRead();
    return super.newTripFuture;
  }

  @override
  set newTripFuture(ObservableFuture<bool> value) {
    _$newTripFutureAtom.reportWrite(value, super.newTripFuture, () {
      super.newTripFuture = value;
    });
  }

  late final _$createNewTripAsyncAction =
      AsyncAction('_NewTripStore.createNewTrip', context: context);

  @override
  Future<dynamic> createNewTrip(CreateTripParams params) {
    return _$createNewTripAsyncAction.run(() => super.createNewTrip(params));
  }

  late final _$_NewTripStoreActionController =
      ActionController(name: '_NewTripStore', context: context);

  @override
  void setSuccess(bool value) {
    final _$actionInfo = _$_NewTripStoreActionController.startAction(
        name: '_NewTripStore.setSuccess');
    try {
      return super.setSuccess(value);
    } finally {
      _$_NewTripStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
response: ${response},
newTripFuture: ${newTripFuture},
isLoading: ${isLoading}
    ''';
  }
}

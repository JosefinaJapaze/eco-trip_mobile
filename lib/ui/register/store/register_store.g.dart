// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_RegisterStore.isLoading'))
          .value;

  late final _$successAtom =
      Atom(name: '_RegisterStore.success', context: context);

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

  late final _$registerFutureAtom =
      Atom(name: '_RegisterStore.registerFuture', context: context);

  @override
  ObservableFuture<RegisterResult> get registerFuture {
    _$registerFutureAtom.reportRead();
    return super.registerFuture;
  }

  @override
  set registerFuture(ObservableFuture<RegisterResult> value) {
    _$registerFutureAtom.reportWrite(value, super.registerFuture, () {
      super.registerFuture = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_RegisterStore.register', context: context);

  @override
  Future<dynamic> register(RegisterParams req) {
    return _$registerAsyncAction.run(() => super.register(req));
  }

  @override
  String toString() {
    return '''
success: ${success},
registerFuture: ${registerFuture},
isLoading: ${isLoading}
    ''';
  }
}

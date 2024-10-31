// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_step_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ValidationStepStore on _ValidationStepStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_ValidationStepStore.isLoading'))
          .value;

  late final _$successAtom =
      Atom(name: '_ValidationStepStore.success', context: context);

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

  late final _$firstStepSuccessAtom =
      Atom(name: '_ValidationStepStore.firstStepSuccess', context: context);

  @override
  bool get firstStepSuccess {
    _$firstStepSuccessAtom.reportRead();
    return super.firstStepSuccess;
  }

  @override
  set firstStepSuccess(bool value) {
    _$firstStepSuccessAtom.reportWrite(value, super.firstStepSuccess, () {
      super.firstStepSuccess = value;
    });
  }

  late final _$dniPreSignedResultAtom =
      Atom(name: '_ValidationStepStore.dniPreSignedResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get dniPreSignedResult {
    _$dniPreSignedResultAtom.reportRead();
    return super.dniPreSignedResult;
  }

  @override
  set dniPreSignedResult(ObservableFuture<PreSignedResult?> value) {
    _$dniPreSignedResultAtom.reportWrite(value, super.dniPreSignedResult, () {
      super.dniPreSignedResult = value;
    });
  }

  late final _$dniUploadResultAtom =
      Atom(name: '_ValidationStepStore.dniUploadResult', context: context);

  @override
  ObservableFuture<bool> get dniUploadResult {
    _$dniUploadResultAtom.reportRead();
    return super.dniUploadResult;
  }

  @override
  set dniUploadResult(ObservableFuture<bool> value) {
    _$dniUploadResultAtom.reportWrite(value, super.dniUploadResult, () {
      super.dniUploadResult = value;
    });
  }

  late final _$certificateResultAtom =
      Atom(name: '_ValidationStepStore.certificateResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get certificateResult {
    _$certificateResultAtom.reportRead();
    return super.certificateResult;
  }

  @override
  set certificateResult(ObservableFuture<PreSignedResult?> value) {
    _$certificateResultAtom.reportWrite(value, super.certificateResult, () {
      super.certificateResult = value;
    });
  }

  late final _$certificateUploadResultAtom = Atom(
      name: '_ValidationStepStore.certificateUploadResult', context: context);

  @override
  ObservableFuture<bool> get certificateUploadResult {
    _$certificateUploadResultAtom.reportRead();
    return super.certificateUploadResult;
  }

  @override
  set certificateUploadResult(ObservableFuture<bool> value) {
    _$certificateUploadResultAtom
        .reportWrite(value, super.certificateUploadResult, () {
      super.certificateUploadResult = value;
    });
  }

  @override
  String toString() {
    return '''
success: ${success},
firstStepSuccess: ${firstStepSuccess},
dniPreSignedResult: ${dniPreSignedResult},
dniUploadResult: ${dniUploadResult},
certificateResult: ${certificateResult},
certificateUploadResult: ${certificateUploadResult},
isLoading: ${isLoading}
    ''';
  }
}

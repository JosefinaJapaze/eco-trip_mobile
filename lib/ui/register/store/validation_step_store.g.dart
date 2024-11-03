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

  late final _$secondStepSuccessAtom =
      Atom(name: '_ValidationStepStore.secondStepSuccess', context: context);

  @override
  bool get secondStepSuccess {
    _$secondStepSuccessAtom.reportRead();
    return super.secondStepSuccess;
  }

  @override
  set secondStepSuccess(bool value) {
    _$secondStepSuccessAtom.reportWrite(value, super.secondStepSuccess, () {
      super.secondStepSuccess = value;
    });
  }

  late final _$thirdStepSuccessAtom =
      Atom(name: '_ValidationStepStore.thirdStepSuccess', context: context);

  @override
  bool get thirdStepSuccess {
    _$thirdStepSuccessAtom.reportRead();
    return super.thirdStepSuccess;
  }

  @override
  set thirdStepSuccess(bool value) {
    _$thirdStepSuccessAtom.reportWrite(value, super.thirdStepSuccess, () {
      super.thirdStepSuccess = value;
    });
  }

  late final _$fourthStepSuccessAtom =
      Atom(name: '_ValidationStepStore.fourthStepSuccess', context: context);

  @override
  bool get fourthStepSuccess {
    _$fourthStepSuccessAtom.reportRead();
    return super.fourthStepSuccess;
  }

  @override
  set fourthStepSuccess(bool value) {
    _$fourthStepSuccessAtom.reportWrite(value, super.fourthStepSuccess, () {
      super.fourthStepSuccess = value;
    });
  }

  late final _$userTypeAtom =
      Atom(name: '_ValidationStepStore.userType', context: context);

  @override
  String get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(String value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
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

  late final _$licenseResultAtom =
      Atom(name: '_ValidationStepStore.licenseResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get licenseResult {
    _$licenseResultAtom.reportRead();
    return super.licenseResult;
  }

  @override
  set licenseResult(ObservableFuture<PreSignedResult?> value) {
    _$licenseResultAtom.reportWrite(value, super.licenseResult, () {
      super.licenseResult = value;
    });
  }

  late final _$licenseUploadResultAtom =
      Atom(name: '_ValidationStepStore.licenseUploadResult', context: context);

  @override
  ObservableFuture<bool> get licenseUploadResult {
    _$licenseUploadResultAtom.reportRead();
    return super.licenseUploadResult;
  }

  @override
  set licenseUploadResult(ObservableFuture<bool> value) {
    _$licenseUploadResultAtom.reportWrite(value, super.licenseUploadResult, () {
      super.licenseUploadResult = value;
    });
  }

  late final _$greenCardResultAtom =
      Atom(name: '_ValidationStepStore.greenCardResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get greenCardResult {
    _$greenCardResultAtom.reportRead();
    return super.greenCardResult;
  }

  @override
  set greenCardResult(ObservableFuture<PreSignedResult?> value) {
    _$greenCardResultAtom.reportWrite(value, super.greenCardResult, () {
      super.greenCardResult = value;
    });
  }

  late final _$greenCardUploadResultAtom = Atom(
      name: '_ValidationStepStore.greenCardUploadResult', context: context);

  @override
  ObservableFuture<bool> get greenCardUploadResult {
    _$greenCardUploadResultAtom.reportRead();
    return super.greenCardUploadResult;
  }

  @override
  set greenCardUploadResult(ObservableFuture<bool> value) {
    _$greenCardUploadResultAtom.reportWrite(value, super.greenCardUploadResult,
        () {
      super.greenCardUploadResult = value;
    });
  }

  late final _$insuranceResultAtom =
      Atom(name: '_ValidationStepStore.insuranceResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get insuranceResult {
    _$insuranceResultAtom.reportRead();
    return super.insuranceResult;
  }

  @override
  set insuranceResult(ObservableFuture<PreSignedResult?> value) {
    _$insuranceResultAtom.reportWrite(value, super.insuranceResult, () {
      super.insuranceResult = value;
    });
  }

  late final _$insuranceUploadResultAtom = Atom(
      name: '_ValidationStepStore.insuranceUploadResult', context: context);

  @override
  ObservableFuture<bool> get insuranceUploadResult {
    _$insuranceUploadResultAtom.reportRead();
    return super.insuranceUploadResult;
  }

  @override
  set insuranceUploadResult(ObservableFuture<bool> value) {
    _$insuranceUploadResultAtom.reportWrite(value, super.insuranceUploadResult,
        () {
      super.insuranceUploadResult = value;
    });
  }

  late final _$plateResultAtom =
      Atom(name: '_ValidationStepStore.plateResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get plateResult {
    _$plateResultAtom.reportRead();
    return super.plateResult;
  }

  @override
  set plateResult(ObservableFuture<PreSignedResult?> value) {
    _$plateResultAtom.reportWrite(value, super.plateResult, () {
      super.plateResult = value;
    });
  }

  late final _$plateUploadResultAtom =
      Atom(name: '_ValidationStepStore.plateUploadResult', context: context);

  @override
  ObservableFuture<bool> get plateUploadResult {
    _$plateUploadResultAtom.reportRead();
    return super.plateUploadResult;
  }

  @override
  set plateUploadResult(ObservableFuture<bool> value) {
    _$plateUploadResultAtom.reportWrite(value, super.plateUploadResult, () {
      super.plateUploadResult = value;
    });
  }

  late final _$serviceBillResultAtom =
      Atom(name: '_ValidationStepStore.serviceBillResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get serviceBillResult {
    _$serviceBillResultAtom.reportRead();
    return super.serviceBillResult;
  }

  @override
  set serviceBillResult(ObservableFuture<PreSignedResult?> value) {
    _$serviceBillResultAtom.reportWrite(value, super.serviceBillResult, () {
      super.serviceBillResult = value;
    });
  }

  late final _$serviceBillUploadResultAtom = Atom(
      name: '_ValidationStepStore.serviceBillUploadResult', context: context);

  @override
  ObservableFuture<bool> get serviceBillUploadResult {
    _$serviceBillUploadResultAtom.reportRead();
    return super.serviceBillUploadResult;
  }

  @override
  set serviceBillUploadResult(ObservableFuture<bool> value) {
    _$serviceBillUploadResultAtom
        .reportWrite(value, super.serviceBillUploadResult, () {
      super.serviceBillUploadResult = value;
    });
  }

  late final _$selfieResultAtom =
      Atom(name: '_ValidationStepStore.selfieResult', context: context);

  @override
  ObservableFuture<PreSignedResult?> get selfieResult {
    _$selfieResultAtom.reportRead();
    return super.selfieResult;
  }

  @override
  set selfieResult(ObservableFuture<PreSignedResult?> value) {
    _$selfieResultAtom.reportWrite(value, super.selfieResult, () {
      super.selfieResult = value;
    });
  }

  late final _$selfieUploadResultAtom =
      Atom(name: '_ValidationStepStore.selfieUploadResult', context: context);

  @override
  ObservableFuture<bool> get selfieUploadResult {
    _$selfieUploadResultAtom.reportRead();
    return super.selfieUploadResult;
  }

  @override
  set selfieUploadResult(ObservableFuture<bool> value) {
    _$selfieUploadResultAtom.reportWrite(value, super.selfieUploadResult, () {
      super.selfieUploadResult = value;
    });
  }

  @override
  String toString() {
    return '''
success: ${success},
firstStepSuccess: ${firstStepSuccess},
secondStepSuccess: ${secondStepSuccess},
thirdStepSuccess: ${thirdStepSuccess},
fourthStepSuccess: ${fourthStepSuccess},
userType: ${userType},
dniPreSignedResult: ${dniPreSignedResult},
dniUploadResult: ${dniUploadResult},
certificateResult: ${certificateResult},
certificateUploadResult: ${certificateUploadResult},
licenseResult: ${licenseResult},
licenseUploadResult: ${licenseUploadResult},
greenCardResult: ${greenCardResult},
greenCardUploadResult: ${greenCardUploadResult},
insuranceResult: ${insuranceResult},
insuranceUploadResult: ${insuranceUploadResult},
plateResult: ${plateResult},
plateUploadResult: ${plateUploadResult},
serviceBillResult: ${serviceBillResult},
serviceBillUploadResult: ${serviceBillUploadResult},
selfieResult: ${selfieResult},
selfieUploadResult: ${selfieUploadResult},
isLoading: ${isLoading}
    ''';
  }
}

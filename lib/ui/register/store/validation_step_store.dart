import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'validation_step_store.g.dart';

enum ValidationStep { first, second, third, fourth }

class ValidationStepStore = _ValidationStepStore with _$ValidationStepStore;

abstract class _ValidationStepStore with Store {
  final RegisterApi _apiClient;
  final Repository _repository;
  final ErrorStore errorStore = ErrorStore();
  ValidationStep currentStep = ValidationStep.first;

  _ValidationStepStore(RegisterApi client, Repository repo)
      : this._apiClient = client,
        this._repository = repo {
    _setupDisposers();
  }

  @observable
  bool success = false;

  @observable
  bool firstStepSuccess = false;

  @observable
  bool secondStepSuccess = false;

  @observable
  bool thirdStepSuccess = false;

  @observable
  bool fourthStepSuccess = false;

  @observable
  String userType = 'driver';

  @observable
  ObservableFuture<PreSignedResult?> dniPreSignedResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> dniUploadResult = ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> certificateResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> certificateUploadResult =
      ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> licenseResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> licenseUploadResult = ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> greenCardResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> greenCardUploadResult = ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> insuranceResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> insuranceUploadResult = ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> plateResult = ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> plateUploadResult = ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> serviceBillResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> serviceBillUploadResult =
      ObservableFuture.value(false);

  @observable
  ObservableFuture<PreSignedResult?> selfieResult =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<bool> selfieUploadResult = ObservableFuture.value(false);

  @computed
  bool get isLoading =>
      dniPreSignedResult.status == FutureStatus.pending ||
      certificateResult.status == FutureStatus.pending ||
      dniUploadResult.status == FutureStatus.pending ||
      certificateUploadResult.status == FutureStatus.pending ||
      licenseResult.status == FutureStatus.pending ||
      licenseUploadResult.status == FutureStatus.pending ||
      greenCardResult.status == FutureStatus.pending ||
      greenCardUploadResult.status == FutureStatus.pending ||
      insuranceResult.status == FutureStatus.pending ||
      insuranceUploadResult.status == FutureStatus.pending ||
      plateResult.status == FutureStatus.pending ||
      plateUploadResult.status == FutureStatus.pending ||
      serviceBillResult.status == FutureStatus.pending ||
      serviceBillUploadResult.status == FutureStatus.pending ||
      selfieResult.status == FutureStatus.pending ||
      selfieUploadResult.status == FutureStatus.pending;

  setStep(ValidationStep step) {
    switch (step) {
      case ValidationStep.first:
        currentStep = ValidationStep.first;
        firstStepSuccess = false;
        secondStepSuccess = false;
        thirdStepSuccess = false;
        fourthStepSuccess = false;
        break;
      case ValidationStep.second:
        currentStep = ValidationStep.second;
        secondStepSuccess = false;
        thirdStepSuccess = false;
        fourthStepSuccess = false;
        break;
      case ValidationStep.third:
        currentStep = ValidationStep.third;
        thirdStepSuccess = false;
        fourthStepSuccess = false;
        break;
      case ValidationStep.fourth:
        currentStep = ValidationStep.fourth;
        fourthStepSuccess = false;
        break;
    }
  }

  Future<String> uploadFile(DocumentType documentType, File file) async {
    final future = _apiClient.getPresignedURL(documentType);
    switch (documentType) {
      case DocumentType.dni:
        dniPreSignedResult = ObservableFuture(future);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateResult = ObservableFuture(future);
        break;
      case DocumentType.license:
        licenseResult = ObservableFuture(future);
        break;
      case DocumentType.greenCard:
        greenCardResult = ObservableFuture(future);
        break;
      case DocumentType.insurance:
        insuranceResult = ObservableFuture(future);
        break;
      case DocumentType.plate:
        plateResult = ObservableFuture(future);
        break;
      case DocumentType.serviceBill:
        serviceBillResult = ObservableFuture(future);
        break;
      case DocumentType.selfie:
        selfieResult = ObservableFuture(future);
        break;
      default:
        setCurrentStepSuccess(false);
        throw Exception('Invalid document type');
    }

    PreSignedResult preSignedResult;
    try {
      preSignedResult = await future;
    } catch (e) {
      setCurrentStepSuccess(false);
      print('Failed to get pre-signed URL: $e');
      errorStore.errorMessage = 'Error al intentar subir el archivo';
      throw e;
    }

    final uploadKey = preSignedResult.key;
    try {
      final token = await _repository.authToken;
      if (token == null) {
        throw Exception('Token is null');
      }
      final userId = JWT.decode(token).payload['userId'];
      await _repository.saveUserSubmissionKey(
          userId, uploadKey, documentType.name);
    } catch (e) {
      setCurrentStepSuccess(false);
      errorStore.errorMessage = 'Error al intentar subir el archivo';
      print('Failed to save key to repo: $e');
      throw e;
    }
    switch (documentType) {
      case DocumentType.dni:
        dniPreSignedResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.license:
        licenseResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.greenCard:
        greenCardResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.insurance:
        insuranceResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.plate:
        plateResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.serviceBill:
        serviceBillResult = ObservableFuture.value(preSignedResult);
        break;
      case DocumentType.selfie:
        selfieResult = ObservableFuture.value(preSignedResult);
        break;
      default:
        setCurrentStepSuccess(false);
        throw Exception('Invalid document type');
    }

    final uploadFuture = _apiClient.uploadDocument(preSignedResult.url, file);
    switch (documentType) {
      case DocumentType.dni:
        dniUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.license:
        licenseUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.greenCard:
        greenCardUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.insurance:
        insuranceUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.plate:
        plateUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.serviceBill:
        serviceBillUploadResult = ObservableFuture(uploadFuture);
        break;
      case DocumentType.selfie:
        selfieUploadResult = ObservableFuture(uploadFuture);
        break;
      default:
        setCurrentStepSuccess(false);
        throw Exception('Invalid document type');
    }

    try {
      await uploadFuture;
    } catch (e) {
      setCurrentStepSuccess(false);
      errorStore.errorMessage = 'Error al intentar subir el archivo';
      throw e;
    }

    switch (documentType) {
      case DocumentType.dni:
        dniUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.license:
        licenseUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.greenCard:
        greenCardUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.insurance:
        insuranceUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.plate:
        plateUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.serviceBill:
        serviceBillUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.selfie:
        selfieUploadResult = ObservableFuture.value(true);
        break;
      default:
        setCurrentStepSuccess(false);
        throw Exception('Invalid document type');
    }

    checkStepCompleted();
    return uploadKey;
  }

  Future<bool> submitUserValidation() async {
    final token = await _repository.authToken;
    if (token == null) {
      throw Exception('Token is null');
    }
    final userId = JWT.decode(token).payload['userId'];
    final dniKey =
        await _repository.getUserSubmissionKey(userId, DocumentType.dni.name);
    final goodBehaviorKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.goodBehaviourCertificate.name);
    final drivingLicenseKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.license.name);
    final greenCardKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.greenCard.name);
    final insuranceKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.insurance.name);
    final licensePlateKey =
        await _repository.getUserSubmissionKey(userId, DocumentType.plate.name);
    final exampleInvoiceKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.serviceBill.name);
    final selfPhotoKey = await _repository.getUserSubmissionKey(
        userId, DocumentType.selfie.name);

    if (dniKey == null ||
        goodBehaviorKey == null ||
        exampleInvoiceKey == null ||
        selfPhotoKey == null) {
      setCurrentStepSuccess(false);
      throw Exception('Missing submission keys');
    }

    final request = SubmitUserValidationRequest(
      userType: this.userType,
      dniKey: dniKey,
      goodBehaviorKey: goodBehaviorKey,
      drivingLicenseKey: drivingLicenseKey,
      greenCardKey: greenCardKey,
      insuranceKey: insuranceKey,
      licensePlateKey: licensePlateKey,
      exampleInvoiceKey: exampleInvoiceKey,
      selfPhotoKey: selfPhotoKey,
    );

    final future = _apiClient.submitUserValidation(request);
    try {
      await future;
    } catch (e) {
      setCurrentStepSuccess(false);
      errorStore.errorMessage = 'Error al intentar finalizar el registro';
      print('Failed to submit user validation: $e');
      throw e;
    }

    success = true;
    setCurrentStepSuccess(success);

    _repository.removeAuthToken();
    _repository.saveIsLoggedIn(false);

    return success;
  }

  setCurrentStepSuccess(bool success) {
    switch (currentStep) {
      case ValidationStep.first:
        firstStepSuccess = success;
        break;
      case ValidationStep.second:
        secondStepSuccess = success;
        break;
      case ValidationStep.third:
        thirdStepSuccess = success;
        break;
      case ValidationStep.fourth:
        fourthStepSuccess = success;
        break;
    }
  }

  checkStepCompleted() {
    switch (currentStep) {
      case ValidationStep.first:
        if (dniUploadResult.status == FutureStatus.fulfilled &&
            certificateUploadResult.status == FutureStatus.fulfilled) {
          firstStepSuccess = true;
        }
        break;
      case ValidationStep.second:
        if (licenseUploadResult.status == FutureStatus.fulfilled &&
            greenCardUploadResult.status == FutureStatus.fulfilled &&
            insuranceUploadResult.status == FutureStatus.fulfilled &&
            plateUploadResult.status == FutureStatus.fulfilled) {
          secondStepSuccess = true;
        }
        break;
      case ValidationStep.third:
        if (serviceBillUploadResult.status == FutureStatus.fulfilled) {
          thirdStepSuccess = true;
        }
        break;
      case ValidationStep.fourth:
        if (selfieUploadResult.status == FutureStatus.fulfilled) {
          fourthStepSuccess = true;
        }
        break;
    }
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => firstStepSuccess, (_) => firstStepSuccess = false,
          delay: 200),
      reaction((_) => secondStepSuccess, (_) => secondStepSuccess = false,
          delay: 200),
      reaction((_) => thirdStepSuccess, (_) => thirdStepSuccess = false,
          delay: 200),
      reaction((_) => fourthStepSuccess, (_) => fourthStepSuccess = false,
          delay: 200),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

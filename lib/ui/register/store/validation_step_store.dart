import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:mobx/mobx.dart';

part 'validation_step_store.g.dart';

class ValidationStepStore = _ValidationStepStore with _$ValidationStepStore;

abstract class _ValidationStepStore with Store {
  final RegisterApi _apiClient;
  final Repository _repository;

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

  @computed
  bool get isLoading =>
      dniPreSignedResult.status == FutureStatus.pending ||
      certificateResult.status == FutureStatus.pending ||
      dniUploadResult.status == FutureStatus.pending ||
      certificateUploadResult.status == FutureStatus.pending;

  Future<String> uploadFile(DocumentType documentType, File file) async {
    final future = _apiClient.getPresignedURL(documentType);
    switch (documentType) {
      case DocumentType.dni:
        dniPreSignedResult = ObservableFuture(future);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateResult = ObservableFuture(future);
        break;
      default:
        throw Exception('Invalid document type');
    }

    final preSignedResult = await future;
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
      default:
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
      default:
        throw Exception('Invalid document type');
    }

    await uploadFuture;
    switch (documentType) {
      case DocumentType.dni:
        dniUploadResult = ObservableFuture.value(true);
        break;
      case DocumentType.goodBehaviourCertificate:
        certificateUploadResult = ObservableFuture.value(true);
        break;
      default:
        throw Exception('Invalid document type');
    }

    return uploadKey;
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

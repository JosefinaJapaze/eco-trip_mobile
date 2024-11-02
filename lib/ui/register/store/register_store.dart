import 'package:ecotrip/data/network/apis/auth/auth_api.dart';
import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/auth/auth.dart';
import 'package:ecotrip/models/user/register_result.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../../stores/form/form_store.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final RegisterApi _apiClient;
  final AuthApi _authApi;
  final Repository _repository;
  final FormErrorStore formErrorStore = FormErrorStore();
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _RegisterStore(RegisterApi client, AuthApi authApi, Repository repo)
      : this._apiClient = client,
        this._authApi = authApi,
        this._repository = repo {
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<RegisterResult> emptyRegisterResult =
      ObservableFuture.value(
          RegisterResult(resultStatus: RegisterStatus.error));

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<RegisterResult> registerFuture = emptyRegisterResult;

  @computed
  bool get isLoading => registerFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future register(RegisterParams req) async {
    final future = _apiClient.register(req);
    registerFuture = ObservableFuture(future);
    RegisterResult registerResult;
    try {
      registerResult = await future;
    } catch (e) {
      this.success = false;
      errorStore.errorMessage = 'Error al registrar';
      throw e;
    }

    if (registerResult.resultStatus == RegisterStatus.userAlreadyExists) {
      errorStore.errorMessage = 'El email ${req.email} ya existe';
      this.success = false;
      return null;
    }
    if (registerResult.resultStatus != RegisterStatus.success) {
      this.success = false;
      errorStore.errorMessage = 'Error al registrar';
      return null;
    }

    String token;
    LoginResult authRes;
    try {
      authRes = await _authApi.login(req.email, req.password);
    } catch (e) {
      errorStore.errorMessage = 'Error al registrar';
      this.success = false;
      throw e;
    }

    if (authRes.resultStatus != AuthResultStatus.successful) {
      throw Exception('Failed to login');
    }
    if (authRes.token == null) {
      throw Exception('Token is null');
    }
    token = authRes.token!;
    _repository.saveAuthToken(token);
    _repository.saveIsLoggedIn(true);
    this.success = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

import 'package:ecotrip/data/network/apis/auth/auth_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/models/auth/auth.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorStore formErrorStore = FormErrorStore();
  final ErrorStore errorStore = ErrorStore();
  final AuthApi _authApi;
  final Repository _repository;

  _FormStore(
    AuthApi authApi,
    Repository repo,
  )   : this._authApi = authApi,
        this._repository = repo {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  static ObservableFuture<LoginResult> emptyLoginResponse =
      ObservableFuture.value(
          LoginResult(resultStatus: AuthResultStatus.wrongCredentials));

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  bool success = false;

  @observable
  ObservableFuture<LoginResult> loginFuture = emptyLoginResponse;

  @computed
  bool get loading => loginFuture.status == FutureStatus.pending;

  @computed
  bool get canLogin => userEmail.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserEmail(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "El email no puede estar vacío";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Por favor ingrese un email válido';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "La contraseña no puede estar vacía";
    }
  }

  @action
  Future login() async {
    final future = _authApi.login(userEmail, password);
    LoginResult result;
    try {
      result = await future;
    } catch (e) {
      this.success = false;
      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Los datos ingresados son incorrectos"
          : "Algo salió mal, por favor intente nuevamente";
      throw e;
    }
    if (result.resultStatus == AuthResultStatus.successful) {
      await _repository.saveAuthToken(result.token ?? '');
      await _repository.saveIsLoggedIn(true);
      this.loginFuture = ObservableFuture.value(result);
      this.success = true;
    } else {
      this.success = false;
      errorStore.errorMessage = "Los datos ingresados son incorrectos";
    }

    return null;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}

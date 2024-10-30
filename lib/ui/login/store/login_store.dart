import 'package:ecotrip/data/network/apis/auth/auth_api.dart';
import 'package:ecotrip/models/auth/auth.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../../data/repository.dart';
import '../../../stores/form/form_store.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final AuthApi _apiClient;
  final Repository _repository;
  final FormErrorStore formErrorStore = FormErrorStore();
  final ErrorStore errorStore = ErrorStore();
  bool isLoggedIn = false;

  _UserStore(Repository repository, AuthApi apiClient)
      : this._repository = repository,
        this._apiClient = apiClient {
    _setupDisposers();
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value;
    });
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<LoginResult> emptyLoginResponse =
      ObservableFuture.value(
          LoginResult(resultStatus: AuthResultStatus.wrongCredentials));

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<LoginResult> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @action
  Future login(String email, String password) async {
    final future = _apiClient.login(email, password);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.resultStatus == AuthResultStatus.successful) {
        final token = value.token ?? '';
        if (token == '') {
          throw Exception('backend token is null');
        }
        _repository.saveIsLoggedIn(true);
        _repository.saveAuthToken(token);
        this.isLoggedIn = true;
        this.success = true;
      } else {
        throw Exception('login failed');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  logout() {
    this.isLoggedIn = false;
    _repository.saveIsLoggedIn(false);
    _repository.removeAuthToken();
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

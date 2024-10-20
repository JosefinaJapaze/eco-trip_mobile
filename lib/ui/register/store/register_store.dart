
import 'package:boilerplate/data/network/apis/user/register_api.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/auth/auth.dart';
import 'package:boilerplate/models/user/register_result.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../../stores/form/form_store.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final RegisterApi _apiClient;
  final Repository _repository;
  final FormErrorStore formErrorStore = FormErrorStore();
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _RegisterStore(RegisterApi client, Repository repo) : this._apiClient = client, this._repository = repo {
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
  ObservableFuture.value(RegisterResult(resultStatus: AuthResultStatus.wrongCredentials));

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
    await future.then((value) async {
      if (value.resultStatus == AuthResultStatus.successful) {
        _repository.saveIsLoggedIn(true);
        this.success = true;
      } else {
        print('failed to register');
      }
    }).catchError((e) {
      print(e);
      this.success = false;
      throw e;
    });
  }

  Future getUploadKey(String documentType) async {
    try {
      final response = await _apiClient.getPresignedURL(documentType);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
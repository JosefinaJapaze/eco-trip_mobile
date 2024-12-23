import 'package:ecotrip/data/network/apis/trip/trip_api.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'new_trip_store.g.dart';

class NewTripStore = _NewTripStore with _$NewTripStore;

abstract class _NewTripStore with Store {
  final Repository _repository;
  final TripApi _tripApi;
  final ErrorStore errorStore = ErrorStore();

  _NewTripStore(Repository repository, TripApi api)
      : this._repository = repository,
        this._tripApi = api {
    _setupDisposers();
  }

  @observable
  bool success = false;

  @observable
  ObservableFuture<bool> response = ObservableFuture.value(false);

  @computed
  bool get isLoading => response.status == FutureStatus.pending;

  @action
  void setSuccess(bool value) {
    success = value;
  }

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  static ObservableFuture<bool> emptyResponse = ObservableFuture.value(false);

  @observable
  ObservableFuture<bool> newTripFuture = emptyResponse;

  @action
  Future createNewTrip(CreateTripParams params) async {
    final future = _tripApi.insertTrip(params);
    newTripFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value) {
        setSuccess(true);
      }
    });
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

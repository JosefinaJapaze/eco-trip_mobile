import 'package:ecotrip/data/local/datasources/trip_datasource.dart';
import 'package:ecotrip/data/network/apis/auth/auth_api.dart';
import 'package:ecotrip/data/network/apis/chat/chat_api.dart';
import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/data/network/rest_client.dart';
import 'package:ecotrip/data/repository.dart';
import 'package:ecotrip/data/sharedpref/shared_preference_helper.dart';
import 'package:ecotrip/di/module/local_module.dart';
import 'package:ecotrip/stores/error/error_store.dart';
import 'package:ecotrip/stores/form/form_store.dart';
import 'package:ecotrip/stores/language/language_store.dart';
import 'package:ecotrip/stores/theme/theme_store.dart';
import 'package:ecotrip/ui/chats/store/chats_store.dart';
import 'package:ecotrip/ui/join_trip/store/join_trip_store.dart';
import 'package:ecotrip/ui/login/store/login_store.dart';
import 'package:ecotrip/ui/my_trips/store/my_trips_store.dart';
import 'package:ecotrip/ui/new_trip/store/new_trip_store.dart';
import 'package:ecotrip/ui/register/store/register_store.dart';
import 'package:ecotrip/ui/register/store/validation_step_store.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/apis/trip/trip_api.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton(RestClient());

  // data sources
  getIt.registerSingleton(TripDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(getIt<SharedPreferenceHelper>()));

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(TripApi(getIt<RestClient>(), getIt<Repository>()));
  getIt
      .registerSingleton(RegisterApi(getIt<RestClient>(), getIt<Repository>()));
  getIt.registerSingleton(AuthApi(getIt<RestClient>()));
  getIt.registerSingleton(ChatApi(getIt<RestClient>(), getIt<Repository>()));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(FormStore(getIt<AuthApi>(), getIt<Repository>()));
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(NewTripStore(getIt<TripApi>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(getIt<Repository>(), getIt<AuthApi>()));
  getIt.registerSingleton(RegisterStore(
      getIt<RegisterApi>(), getIt<AuthApi>(), getIt<Repository>()));
  getIt.registerSingleton(
      ValidationStepStore(getIt<RegisterApi>(), getIt<Repository>()));
  getIt.registerSingleton(JoinTripStore(getIt<TripApi>()));
  getIt.registerSingleton(MyTripsStore(getIt<TripApi>()));
  getIt.registerSingleton(ChatsStore(getIt<ChatApi>()));
}

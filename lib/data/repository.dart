import 'dart:async';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/user/register_request.dart';
import 'package:sembast/sembast.dart';

import '../models/trip/trip.dart';
import '../models/trip/trip_list.dart';
import 'local/constants/db_constants.dart';
import 'local/datasources/trip_datasource.dart';
import 'network/apis/trip/trip_api.dart';

class Repository {
  // data source object
  final TripDataSource _tripDataSource;

  // api objects
  final TripApi _tripApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._tripApi, this._sharedPrefsHelper, this._tripDataSource);

  // Trip: ---------------------------------------------------------------------
  Future<TripList> getTrips() async {
    return await _tripDataSource.getTripsFromDb().then((tripsList) {
      return tripsList;
    }).catchError((error) => throw error);
  }

  Future<List<Trip>> findTripById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _tripDataSource
        .getAllSortedByFilter(filters: filters)
        .then((trips) => trips)
        .catchError((error) => throw error);
  }

  Future<int> insert(Trip trip) => _tripDataSource
      .insert(trip)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Trip trip) => _tripDataSource
      .update(trip)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Trip trip) => _tripDataSource
      .update(trip)
      .then((id) => id)
      .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), ()=> true);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Register:------------------------------------------------------------------
  Future<bool> register(RegisterRequest req) async {
    return await Future.delayed(Duration(seconds: 2), ()=> true);
  }

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
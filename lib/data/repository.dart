import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ecotrip/data/sharedpref/shared_preference_helper.dart';

class Repository {
  final SharedPreferenceHelper _sharedPrefsHelper;

  Repository(this._sharedPrefsHelper);

  Future<void> saveAuthToken(String authToken) =>
      _sharedPrefsHelper.saveAuthToken(authToken);

  Future<String?> get authToken => _sharedPrefsHelper.authToken;

  Future<bool> removeAuthToken() => _sharedPrefsHelper.removeAuthToken();

  Future saveUserSubmissionKey(int userId, String key, String documentType) =>
      _sharedPrefsHelper.saveUserSubmissionKey(userId, key, documentType);

  Future<String?> getUserSubmissionKey(int userId, String documentType) =>
      _sharedPrefsHelper.getUserSubmissionKey(userId, documentType);

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  Future<String?> get userType => _sharedPrefsHelper.getUserType();

  Future<bool> isUserVerified() async {
    final token = await authToken;
    if (token == null) return false;
    final jwt = JWT.decode(token);
    return jwt.payload['validated'] == true;
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

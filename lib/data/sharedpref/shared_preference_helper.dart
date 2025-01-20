import 'dart:async';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    final jwt = JWT.decode(authToken);
    final userType = jwt.payload['userType'] as String;
    await saveUserType(userType);
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    await removeUserType();
    return _sharedPreference.remove(Preferences.auth_token);
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  Future<bool> saveUserType(String userType) async {
    return _sharedPreference.setString(Preferences.user_type, userType);
  }

  Future<String?> getUserType() async {
    return _sharedPreference.getString(Preferences.user_type);
  }

  Future<bool> removeUserType() async {
    return _sharedPreference.remove(Preferences.user_type);
  }

  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

  Future<void> saveUserSubmissionKey(
      int userId, String uploadKey, String documentType) {
    final kvKey = "${userId}_${documentType}";
    return _sharedPreference.setString(kvKey, uploadKey);
  }

  Future<String?> getUserSubmissionKey(int userId, String documentType) {
    final kvKey = "${userId}_${documentType}";
    return Future.value(_sharedPreference.getString(kvKey));
  }
}

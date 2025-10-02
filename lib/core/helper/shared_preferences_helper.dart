import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final SharedPreferences _prefs;

  // Keys for storing values
  static const String _keyAccessToken = 'access_token';
  static const String _keyUserId = 'user_id';
  static const String _isLoggedIn = 'is_logged_in';

  SharedPreferencesHelper(this._prefs);

  // Save methods
  void saveAccessToken(String token) {
    _prefs.setString(_keyAccessToken, token);
  }

  void saveUserId(String userId) {
    _prefs.setString(_keyUserId, userId);
  }

   void saveIsLoggedIn(bool value) {
    _prefs.setBool(_isLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedIn) ?? false;
  }

// Retrieve methods
  String? getAccessToken() {
    return _prefs.getString(_keyAccessToken);
  }

  String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

// Clear all saved data
  void clearAll() {
    _prefs.clear();
  }

  void logAll() {
    if (kDebugMode) {
      debugPrint('AccessToken: ${getAccessToken()}');
      debugPrint('UserId: ${getUserId()}');
    }
  }
}

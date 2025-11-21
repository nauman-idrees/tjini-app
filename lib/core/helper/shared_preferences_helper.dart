import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/login_response.dart';
import '../../models/notification_model.dart';

class SharedPreferencesHelper {
  final SharedPreferences _prefs;

  // Keys for storing values
  static const String _keyAccessToken = 'access_token';
  static const String _keyUserId = 'user_id';
  static const String _isLoggedIn = 'is_logged_in';
  static const String _keyFcmToken = 'fcm_token';
  static const String _keyCurrentUser = 'user';
  static const String _keyNotificationList = 'notification_data';
  static const String _keyNextSep = '_keyNextStep';
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

  void saveFcmToken(String token) {
    _prefs.setString(_keyFcmToken, token);
  }

  Future<void> saveCurrentUser(LoginResponse user) async {
    await _prefs.setString(_keyCurrentUser, jsonEncode(user.toJson()));
  }

  LoginResponse? getCurrentUser() {
    final jsonString = _prefs.getString(_keyCurrentUser);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LoginResponse.fromJson(jsonMap);
    }
    return null;
  }

  //  Future<void> addNotification(NotificationModels notification) async {
  //    final existing = getNotificationList();
  //
  //    existing.add(notification);
  //    await _prefs.setString(
  //      _keyNotificationList,
  //      NotificationModels.listToJson(existing),
  //    );
  //  }
  //
  // List<NotificationModels> getNotificationList()  {
  //    final jsonString = _prefs.getString(_keyNotificationList);
  //    if (jsonString == null) return [];
  //    return NotificationModels.listFromJson(jsonString);
  //  }
  //
  //  Future<void> deleteOldNotifications() async {
  //    final list = getNotificationList();
  //    final now = DateTime.now();
  //
  //    final filtered = list.where((n) {
  //      final diff = now.difference(n.dateTime);
  //      return diff.inHours < 2;
  //    }).toList();
  //
  //    await _prefs.setString(
  //      _keyNotificationList,
  //      NotificationModels.listToJson(filtered),
  //    );
  //  }
  //
  //  NotificationModels? getLatestNotification()  {
  //     deleteOldNotifications();
  //
  //    final list =  getNotificationList();
  //    if (list.isEmpty) return null;
  //
  //    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  //    return list.first;
  //  }

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

  String? getFcmToken() {
    return _prefs.getString(_keyFcmToken);
  }

  // Clear all saved data
  void clearAll() {
    _prefs.remove(_keyAccessToken);
    _prefs.remove(_keyUserId);
    _prefs.remove(_isLoggedIn);
    _prefs.remove(_keyCurrentUser);
  }

  void logAll() {
    if (kDebugMode) {
      debugPrint('AccessToken: ${getAccessToken()}');
      debugPrint('UserId: ${getUserId()}');
    }
  }

  Future<void> saveIsNextStep(bool value) async {
    await _prefs.setBool(_keyNextSep, value);
  }

  bool getIsNextStep() {
    return _prefs.getBool(_keyNextSep) ?? false;
  }
}

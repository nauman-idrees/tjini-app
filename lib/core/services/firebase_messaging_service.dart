import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFCM() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppHandler);
    if (Platform.isIOS) {
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        _firebaseMessagingBackgroundHandler(initialMessage);
      }
    }
    Future.delayed(const Duration(seconds: 5), () async {
      try {
        String? token = await _firebaseMessaging.getToken();
        if (token != null) {
          debugPrint("FCM Token: $token");
          locator<SharedPreferencesHelper>().saveFcmToken(token);
        }
      } on Exception catch (e) {
        // e.recordError(stackTrace: StackTrace.current);
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // locator<SharedPreferencesHelper>().saveNotification(message);
    Future.delayed(const Duration(seconds: 8), () {});
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    // locator<SharedPreferencesHelper>().saveNotification(message);
  }

  static Future<void> _onMessageOpenAppHandler(RemoteMessage message) async {
    // locator<SharedPreferencesHelper>().saveNotification(message);
  }
}

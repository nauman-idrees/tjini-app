import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/models/notification_model.dart';
import 'package:tjini_app/provider/notification_provider.dart';

import 'notification_service.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFCM() async {
    await NotificationService.initialize();

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
    locator<NotificationProvider>().addNewNotification(
        NotificationModels(
          type: message.data['type'],
          dateTime: DateTime.now(),
          message: message.data['message'],
        )
    );
    locator<NotificationProvider>().refreshNotifications();
    print("Background Message:");
    print(message.data);

    String title = message.notification?.title ?? "New Notification";
    String body = message.notification?.body ?? "You have a new message";

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    locator<NotificationProvider>().addNewNotification(
        NotificationModels(
          type: message.data['type'],
          dateTime: DateTime.now(),
          message: message.data['message'],
        )
    );
    locator<NotificationProvider>().refreshNotifications();
    print("Foreground Message:");
    print(message.data);

    String title = message.notification?.title ?? "New Notification";
    String body = message.notification?.body ?? "You have a new message";

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  static Future<void> _onMessageOpenAppHandler(RemoteMessage message) async {
    locator<NotificationProvider>().addNewNotification(
        NotificationModels(
          type: message.data['type'],
          dateTime: DateTime.now(),
          message: message.data['message'],
        )
    );
    locator<NotificationProvider>().refreshNotifications();
    print("Notification Opened:");
    print(message.data);

    String title = message.notification?.title ?? "Opened Notification";
    String body = message.notification?.body ?? "App opened from notification";

    await NotificationService.showNotification(
      title: title,
      body: body,
      payload: message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }
}

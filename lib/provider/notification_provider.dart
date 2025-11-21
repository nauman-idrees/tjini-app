import 'package:flutter/material.dart';
import 'package:tjini_app/core/extensions.dart';

import '../core/apis/api_endpoints.dart';
import '../core/apis/api_service.dart';
import '../core/di/locator.dart';
import '../core/enum.dart';
import '../core/helper/shared_preferences_helper.dart';
import '../core/utils/toast_utils.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationItem> _latestNotification = [];
  bool? _isNextStep;

  List<NotificationItem> get latestNotification => _latestNotification;
  bool? get isNextStep => _isNextStep;

  Future<void> saveNextStep(bool value) async {
    final helper = locator<SharedPreferencesHelper>();
    helper.saveIsNextStep(value);
    _isNextStep = helper.getIsNextStep();
    notifyListeners();
  }

  Future<void> sendParentNotification(
    String type,
    String message,
    int userId,
    String token,
  ) async {
    Map<String, dynamic> data = {
      'type': type,
      'message': message,
      'fromUserId': userId,
    };

    final response = await ApiService().sendNotification(
      ApiEndpoints.notify,
      data,
      token,
    );

    if (response.statusCode == 200) {
      getNotification(token);
      ToastUtils.show(
        msg: "Connecté avec succès".hardcoded(),
        type: ToastType.success,
      );
    }
  }

  Future<void> getNotification(
    String token,
  ) async {
    try {
      final response = await ApiService().getNotification(
        ApiEndpoints.notification,
        token,
      );

      _latestNotification = [];

      if (response.statusCode == 200) {
        for (dynamic data in response.data) {
          _latestNotification.add(NotificationItem.fromMap(data));
        }
      }
      notifyListeners();
    } catch (e) {
      _latestNotification = [];
      debugPrint(e.toString());
    }
  }
}

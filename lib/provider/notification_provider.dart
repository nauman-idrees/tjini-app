import 'package:flutter/material.dart';
import 'package:tjini_app/core/extensions.dart';

import '../core/apis/api_endpoints.dart';
import '../core/apis/api_service.dart';
import '../core/di/locator.dart';
import '../core/enum.dart';
import '../core/helper/shared_preferences_helper.dart';
import '../core/utils/toast_utils.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier{
 NotificationModels? _latestNotification;
 bool? _isNextStep;
 bool _initialized = false;

 NotificationModels? get latestNotification => _latestNotification;
 bool? get isNextStep => _isNextStep;

 NotificationProvider() {
  _init();
 }

 /// Load the last saved notification on app startup
 Future<void> _init() async {
  await _loadLatestFromPrefs();
  _initialized = true;
 }

 Future<void> _loadLatestFromPrefs() async {
  final helper = locator<SharedPreferencesHelper>();
  await helper.deleteOldNotifications(); // optional cleanup
  _latestNotification = helper.getLatestNotification();
  _isNextStep = helper.getIsNextStep();
  notifyListeners();
 }

 /// Manually refresh notifications (if needed)
 Future<void> refreshNotifications() async {
  await _loadLatestFromPrefs();
 }

 /// Add new notification and refresh UI immediately
 Future<void> addNewNotification(NotificationModels model) async {
  final helper = locator<SharedPreferencesHelper>();
  await helper.addNotification(model);
  _latestNotification = helper.getLatestNotification();
  notifyListeners();
 }

 Future<void> saveNextStep(bool value) async{
  final helper = locator<SharedPreferencesHelper>();
  helper.saveIsNextStep(value);
  _isNextStep = helper.getIsNextStep();
  notifyListeners();
 }

 bool get isInitialized => _initialized;

 Future<void> sendParentNotification(
     String type,
     String message,
     String userId,
     String token,
     ) async{

  Map<String, dynamic> data = {
   'type': type,
   'message': message,
   'fromUserId': userId,
  };

  final response = await ApiService().sendNotification(
   ApiEndpoints.notify,
   data,
   token
  );

  print("response.statusCode------>${response.statusCode}");

  if(response.statusCode == 200){
   ToastUtils.show(
    msg: "Connecté avec succès".hardcoded(),
    type: ToastType.success,
   );
  }
 }
}
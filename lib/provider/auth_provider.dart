import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/core/utils/toast_utils.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/repositories/remote/iremote_repository.dart';

class AuthProvider extends ChangeNotifier {
  final IRemoteRepository _remoteRepository;

  AuthProvider({required IRemoteRepository remoteRepository})
    : _remoteRepository = remoteRepository;

  bool isLoading = false;

  Future<void> login({
    required String email,
    required String password,
    Function(User)? onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();
    final fcmToken = locator<SharedPreferencesHelper>().getFcmToken();
    final result = await _remoteRepository.login(
      email: email,
      password: password,
      token: fcmToken,
    );
    result.when(
      (data) {
        locator<SharedPreferencesHelper>().saveIsLoggedIn(true);
        ToastUtils.show(
          msg: "Connecté avec succès".hardcoded(),
          type: ToastType.success,
        );
        isLoading = false;
        notifyListeners();
        onSuccess?.call(data.user!);
      },
      (error) {
        ToastUtils.show(msg: error.message, type: ToastType.error);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await _remoteRepository.resetPassword(
      email: email,
      password: password,
    );
    result.when(
      (data) {
        ToastUtils.show(
          msg: "Mot de passe mis à jour avec succès".hardcoded(),
          type: ToastType.success,
        );
        isLoading = false;
        notifyListeners();
        onSuccess?.call();
      },
      (error) {
        ToastUtils.show(msg: error.message, type: ToastType.error);
        isLoading = false;
        notifyListeners();
      },
    );
  }
}

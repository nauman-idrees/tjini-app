import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/core/utils/toast_utils.dart';
import 'package:tjini_app/models/dispatchee_model.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/repositories/remote/iremote_repository.dart';
import 'package:tjini_app/ui/screens/child_detail_screen.dart';
import '../core/enum.dart';
import '../ui/screens/establishment_profile_screen.dart';

class DispatcherProvider extends ChangeNotifier {
  final IRemoteRepository _remoteRepository;

  DispatcherProvider({required IRemoteRepository remoteRepository})
    : _remoteRepository = remoteRepository;

  bool isLoading = false;
  List<DispatcheeModel> dispatchees = [];

  DispatcherAction? _selectedAction;
  ParentStatus? _selectedStudentAction;

  DispatcherAction? get selectedAction => _selectedAction;
  ParentStatus? get selectedStudentAction => _selectedStudentAction;

  bool isSelected(DispatcherAction action) {
    return _selectedAction == action;
  }

  void toggleSelection(DispatcherAction action) {
    if (_selectedAction == action) {
      _selectedAction = null;
    } else {
      _selectedAction = action;
    }
    notifyListeners();
  }

  void toggleStudentSelection(ParentStatus action) {
    if (_selectedStudentAction == action) {
      _selectedStudentAction = null;
    } else {
      _selectedStudentAction = action;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAction = null;
    _selectedStudentAction = null;
    notifyListeners();
  }

  Future<void> fetchInitialData({bool isLoading = true}) async {
    if (isLoading) {
      this.isLoading = true;
    }
    notifyListeners();

    final result = await _remoteRepository.getDispatchees();
    result.when(
      (data) {
        dispatchees = data;
        if (isLoading) {
          this.isLoading = false;
        }
        notifyListeners();
      },
      (error) {
        if (isLoading) {
          this.isLoading = false;
        }
        notifyListeners();

        if (kDebugMode) {
          print("Error fetching dispatchees: $error");
        }
      },
    );
  }

  performAction(
    DispatcherUIAction action,
    int userId, {
    int? delayMinutes,
  }) async {
    LoginResponse? user = locator<SharedPreferencesHelper>().getCurrentUser();
    switch (action) {
      case DispatcherUIAction.receptionCallingYou:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.receptionCalling.code,
          message: DispatcherMessageType.receptionCalling.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
        break;
      case DispatcherUIAction.pickUpNotAvailable:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.carUnavailable.code,
          message: DispatcherMessageType.carUnavailable.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
        break;
      case DispatcherUIAction.additionalDelay:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.additionalDelayTime.code,
          message: DispatcherMessageType.additionalDelayTime.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );

        break;
      case DispatcherUIAction.childOngoing:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.preparing.code,
          message: DispatcherMessageType.preparing.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
      case DispatcherUIAction.childReady:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.ready.code,
          message: DispatcherMessageType.ready.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
      case DispatcherUIAction.childCollected:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.collected.code,
          message: DispatcherMessageType.collected.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
      case DispatcherUIAction.delayTimer:
        if (delayMinutes != null) {
          await _remoteRepository.sendParentNotification(
            type: DispatcherMessageType.dispatcherDelayTime.code,
            message: DispatcherMessageType.dispatcherDelayTime.message
                .replaceAll("(duration-value)", delayMinutes.toString()),
            toUserId: userId,
            fromUserId: user!.user!.id,
          );
        }
        break;
      case DispatcherUIAction.pickUpOnCar:
        await _remoteRepository.sendParentNotification(
          type: DispatcherMessageType.collected.code,
          message: DispatcherMessageType.collected.message,
          toUserId: userId,
          fromUserId: user!.user!.id,
        );
    }
    ToastUtils.show(
      msg: "Parent notified successfully".hardcoded(),
      type: ToastType.success,
    );
    fetchInitialData(isLoading: false);
  }
}

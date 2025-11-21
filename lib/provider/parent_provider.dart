import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/extensions.dart';
import 'package:tjini_app/core/global.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/core/utils/dialog_utils.dart';
import 'package:tjini_app/core/utils/toast_utils.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/models/notification_model.dart' hide User;
import 'package:tjini_app/ui/screens/child_detail_screen.dart';
import '../core/enum.dart';
import '../models/user.dart';
import '../repositories/remote/iremote_repository.dart';

class ParentProvider extends ChangeNotifier {
  final IRemoteRepository _remoteRepository;

  ParentProvider({required IRemoteRepository remoteRepository})
    : _remoteRepository = remoteRepository;

  ParentAction? _selectedAction;
  MainParentAction? _selectedMainAction;

  List<User> relatedParents = [];
  List<NotificationItem> notifications = [];

  ParentAction? get selectedAction => _selectedAction;
  MainParentAction? get selectedMainAction => _selectedMainAction;

  bool isSelected(ParentAction action) {
    return _selectedAction == action;
  }

  void toggleSelection(ParentAction action) {
    if (_selectedAction == action) {
      _selectedAction = null;
    } else {
      _selectedAction = action;
    }
    notifyListeners();
  }

  bool isMainSelected(MainParentAction action) {
    return _selectedMainAction == action;
  }

  void toggleMainSelection(MainParentAction action) {
    if (_selectedMainAction == action) {
      _selectedMainAction = null;
    } else {
      _selectedMainAction = action;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAction = null;
    _selectedMainAction = null;
    notifyListeners();
  }

  Future<void> fetchInitialData() async {
    User? user = locator<SharedPreferencesHelper>().getCurrentUser()?.user;
    if (user != null && user.isPrimary == 0) {
      final result = await _remoteRepository.getTransferNotification();
      result.when((notifications) {
        if (notifications.isEmpty) {
          DialogUtils.showInfoDialog(
            ctx: navigatorKey.currentState!.context,
            desc: "Vous n'avez pas encore attribué l'enfant.".hardcoded(),
            positiveBtnText: "D'ACCORD".hardcoded(),
            onPositiveBtnPressed: () {
              exit(0);
            },
          );
        }
      }, (e) {});
    }
    final result = await _remoteRepository.getNotifications();
    result.when(
      (data) async {
        notifications = data;
        if (user != null && user.isPrimary == 1) {
          bool isItTime = notifications.any(
            (notifications) =>
                notifications.type == ParentMessageType.schoolEnd.code ||
                notifications.type == ParentMessageType.schoolStart.code,
          );
          if (!isItTime) {
            DialogUtils.showInfoDialog(
              ctx: navigatorKey.currentState!.context,
              desc: "Les cours ne commencent ni ne se terminent en ce moment."
                  .hardcoded(),
              positiveBtnText: "D'ACCORD".hardcoded(),
              onPositiveBtnPressed: () {
                exit(0);
              },
            );
            return;
          }
          if (user.isPrimary == 1 &&
              notifications.any(
                (item) => item.type == ParentMessageType.whoComing.code,
              )) {
            final whoComingNotification = notifications.firstWhere(
              (item) => item.type == ParentMessageType.whoComing.code,
            );
            if (whoComingNotification.toUser != null &&
                whoComingNotification.toUser?.isPrimary != null &&
                whoComingNotification.toUser?.isPrimary == 0) {
              DialogUtils.showInfoDialog(
                ctx: navigatorKey.currentState!.context,
                desc: "Vous avez confié l'enfant à quelqu'un d'autre."
                    .hardcoded(),
                positiveBtnText: "D'ACCORD".hardcoded(),
                onPositiveBtnPressed: () {
                  exit(0);
                },
              );
              return;
            }
          }
          if (user.isPrimary == 1) {
            final result = await _remoteRepository.getRelatedParents(
              userId: user.id,
            );
            result.when(
              (parents) {
                relatedParents = parents;
                notifyListeners();
              },
              (error) {
                relatedParents = [];
                // Handle error if needed
              },
            );
          }
        }
      },
      (error) {
        // Handle error if needed
      },
    );
    print(relatedParents.length);
    notifyListeners();
  }

  performAction(
    ParentUIAction action,
  ) async {
    LoginResponse? user = locator<SharedPreferencesHelper>().getCurrentUser();
    if (action == ParentUIAction.readyToGo) {
      await _remoteRepository.sendNotification(
        type: ParentMessageType.readyToGo.code,
        message: ParentMessageType.readyToGo.message,
        fromUserId: user!.user!.id,
      );
    }
    if (action == ParentUIAction.iAmHere) {
      await _remoteRepository.sendNotification(
        type: ParentMessageType.iAmHere.code,
        message: ParentMessageType.iAmHere.message,
        fromUserId: user!.user!.id,
      );
    }
    // if (action == ParentUIAction.pickUpInside) {
    //   await _remoteRepository.sendNotification(
    //     type: ParentMessageType.insidePickup.code,
    //     message: ParentMessageType.insidePickup.message,
    //     fromUserId: user!.user!.id,
    //   );
    // }

    if (action == ParentUIAction.pickUpOnCar) {
      await _remoteRepository.sendNotification(
        type: ParentMessageType.carPickup.code,
        message: ParentMessageType.carPickup.message,
        fromUserId: user!.user!.id,
      );
    }

    if (action == ParentUIAction.pickUpInside) {
      await _remoteRepository.sendNotification(
        type: ParentMessageType.pickupInside.code,
        message: ParentMessageType.pickupInside.message,
        fromUserId: user!.user!.id,
      );
    }

    ToastUtils.show(
      msg: "Le répartiteur a été notifié avec succès".hardcoded(),
      type: ToastType.success,
    );
    await fetchInitialData();
  }

  Future<void> addTime({required int minutes}) async {
    LoginResponse? user = locator<SharedPreferencesHelper>().getCurrentUser();
    if (!notifications.any(
      (item) => item.type == ParentMessageType.arrivalTime.code,
    )) {
      await _remoteRepository.sendNotification(
        type: ParentMessageType.arrivalTime.code,
        message: ParentMessageType.arrivalTime.message.replaceAll(
          "(duration)",
          minutes.toString(),
        ),
        fromUserId: user!.user!.id,
        value: minutes,
      );
      ToastUtils.show(
        msg: "Le répartiteur a été notifié avec succès".hardcoded(),
        type: ToastType.success,
      );
    } else {
      final result = await _remoteRepository.updateDispatcheeTime(
        time: minutes,
      );
      result.when((success) async {
        await _remoteRepository.sendNotification(
          type: ParentMessageType.delayTime.code,
          message: ParentMessageType.delayTime.message.replaceAll(
            "(duration)",
            minutes.toString(),
          ),
          fromUserId: user!.user!.id,
        );
        ToastUtils.show(
          msg: "Le répartiteur a été notifié avec succès".hardcoded(),
          type: ToastType.success,
        );
      }, (error) {});
    }

    await fetchInitialData();
  }

  Future<void> selectWhoComing({required User selectedUser}) async {
    LoginResponse? user = locator<SharedPreferencesHelper>().getCurrentUser();
    bool isPrimary = selectedUser.isPrimary == 1;
    await _remoteRepository.sendNotification(
      type: ParentMessageType.whoComing.code,
      message: ParentMessageType.whoComing.message.replaceAll(
        "(value)",
        selectedUser.firstName.toString(),
      ),
      fromUserId: user!.user!.id,
      toUserId: !isPrimary ? selectedUser.id : null,
    );
    fetchInitialData();
  }
}

enum ParentUIState {
  initial,
  loading,
  loaded,
  error,
}

enum ParentUIAction {
  readyToGo,
  iAmHere,
  addTime,
  whoComing,
  pickUpOnCar,
  pickUpInside,
}

import 'package:flutter/material.dart';
import 'package:tjini_app/core/di/locator.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/models/notification_model.dart';

extension StringExtension on String {
  String hardcoded() {
    return this;
  }
}

extension ParentStatusExtension on ParentAction {
  String title() {
    switch (this) {
      case ParentAction.pickUpOnCar:
        return "Récupération en voiture".hardcoded();
      case ParentAction.pickUpInside:
        return "Récupération à l'intérieur".hardcoded();
    }
  }
}

extension MainParentStatusExtension on MainParentAction {
  String title() {
    switch (this) {
      case MainParentAction.mother:
        return "Mère".hardcoded();
      case MainParentAction.father:
        return "Père".hardcoded();
      case MainParentAction.familyMember:
        return "Membre de la famille".hardcoded();
    }
  }
}

extension DispatcherStatusExtension on DispatcherAction {
  String title() {
    switch (this) {
      case DispatcherAction.receptionCallingYou:
        return "On vous demande à L'accueil. ".hardcoded();
      case DispatcherAction.pickUpCarUnavailable:
        return "Pick up en voiture NON DISPONIBLE. ".hardcoded();
      case DispatcherAction.additionalDelay:
        return "RETARD ADDITIONNEL.".hardcoded();
    }
  }
}

extension ToastColor on ToastType {
  Color getColor() {
    return this == ToastType.message
        ? Colors.grey
        : this == ToastType.error
        ? Colors.red
        : Colors.green;
  }
}

extension ValidateFields on String? {
  String? validateEmail() {
    String? email = this;
    RegExp emailRegex = RegExp(r'^[\w-\.]+(?:\+\d+)?@([\w-]+\.)+[\w-]{2,4}$');
    if (email == null || email.isEmpty) {
      return "L'email est requis".hardcoded();
    } else if (!emailRegex.hasMatch(email)) {
      return "L'email est invalide".hardcoded();
    }
    return null;
  }

  // String? validateField() {
  //   String? email = this;
  //   if (email == null || email.isEmpty) {
  //     return loc.required;
  //   }
  //   return null;
  // }

  String? validatePassword() {
    String? password = this;
    if (password == null || password.isEmpty) {
      return "Le mot de passe est requis".hardcoded();
    } else if (password.length < 8) {
      return "Le mot de passe est invalide".hardcoded();
    }
    return null;
  }

  String? validateConfirmPassword(String password) {
    if (this == null || this!.isEmpty) {
      return "Le mot de passe est requis".hardcoded();
    } else if (this!.length < 8) {
      return "Le mot de passe est invalide".hardcoded();
    } else if (this != password) {
      return "Le mot de passe et la confirmation du mot de passe ne correspondent pas"
          .hardcoded();
    }
    return null;
  }
}

extension ParentMessageTypeMessageExtension on ParentMessageType {
  String get message {
    switch (this) {
      // ---- Parent Side ----
      case ParentMessageType.whoComing:
        return "(value) is coming";
      case ParentMessageType.delayTime:
        return "I will be late for (duration) min.";
      case ParentMessageType.arrivalTime:
        return "I will arrive in (duration) min.";
      case ParentMessageType.arrived:
        return "I'm here";
      case ParentMessageType.carPickup:
        return "Pickup child from inside the car";
      case ParentMessageType.pickupInside:
        return "Pickup child from inside";
      case ParentMessageType.schoolEnd:
        return "School has ended";
      case ParentMessageType.schoolStart:
        return "School has started";
      case ParentMessageType.readyToGo:
        return "I am on my way, please proceed.";
      case ParentMessageType.iAmHere:
        return "I have arrived, please proceed.";
    }
  }

  String get code {
    switch (this) {
      // ---- Parent Side ----
      case ParentMessageType.whoComing:
        return "who-coming";
      case ParentMessageType.delayTime:
        return "delay-time";
      case ParentMessageType.arrivalTime:
        return "arrival-time";
      case ParentMessageType.arrived:
        return "arrived";
      case ParentMessageType.carPickup:
        return "car-pickup";
      case ParentMessageType.pickupInside:
        return "pickup-inside";
      case ParentMessageType.schoolEnd:
        return "school-end";
      case ParentMessageType.schoolStart:
        return "school-start";
      case ParentMessageType.readyToGo:
        return "ready-to-go";
      case ParentMessageType.iAmHere:
        return "i-am-here";
    }
  }
}

extension MessageTypeCodeExtension on DispatcherMessageType {
  String get code {
    switch (this) {
      // ---- Dispatcher Side ----
      case DispatcherMessageType.preparing:
        return "preparing";
      case DispatcherMessageType.ready:
        return "ready";
      case DispatcherMessageType.collected:
        return "collected";
      case DispatcherMessageType.dropped:
        return "dropped";
      case DispatcherMessageType.additionalDelayTime:
        return "additional-delay";
      case DispatcherMessageType.dispatcherDelayTime:
        return "delay-time";
      case DispatcherMessageType.receptionCalling:
        return "reception-calling";
      case DispatcherMessageType.carUnavailable:
        return "car-unavailable";
    }
  }

  String get message {
    switch (this) {
      // ---- Dispatcher Side ----
      case DispatcherMessageType.preparing:
        return "Your child is being prepared for pickup.";
      case DispatcherMessageType.ready:
        return "Your child is ready for pickup.";
      case DispatcherMessageType.collected:
        return "Your child has been collected.";
      case DispatcherMessageType.dropped:
        return "Your child has been dropped off.";
      case DispatcherMessageType.additionalDelayTime:
        return "The dispatcher is experiencing an additional delay.";
      case DispatcherMessageType.dispatcherDelayTime:
        return "The dispatcher is experiencing a delay of (duration-value) minutes.";
      case DispatcherMessageType.receptionCalling:
        return "The reception is trying to reach you.";
      case DispatcherMessageType.carUnavailable:
        return "Pickup by car is currently unavailable.";
    }
  }
}

extension NotificationListingExtensions on List<NotificationItem> {
  bool showWhoComing() {
    LoginResponse? loginResponse = locator<SharedPreferencesHelper>()
        .getCurrentUser();
    if (loginResponse?.user != null) {
      if (loginResponse!.user!.isPrimary == 0) {
        return false;
      }
    }
    if (any((item) => item.type == ParentMessageType.whoComing.code)) {
      return false;
    }
    return true;
  }

  bool showIAmHere() {
    if (any((item) => item.type == ParentMessageType.iAmHere.code)) {
      return false;
    }
    if (any(
      (item) =>
          item.type == ParentMessageType.delayTime.code ||
          item.type == ParentMessageType.arrivalTime.code,
    )) {
      return true;
    }

    return false;
  }

  bool showTimer() {
    LoginResponse? loginResponse = locator<SharedPreferencesHelper>()
        .getCurrentUser();
    bool value = false;
    if (loginResponse?.user != null) {
      if (loginResponse!.user!.isPrimary == 0) {
        value = true;
      }
    }
    if (any((item) => item.type == ParentMessageType.whoComing.code)) {
      value = true;
    }

    if (any((item) => item.type == ParentMessageType.iAmHere.code)) {
      value = false;
    }
    return value;
  }

  bool showAdditionalAcitons() {
    // if (any((item) => item.type == ParentMessageType.carPickup.code)) {
    //   return false;
    // }
    // if (any(
    //   (item) =>
    //       item.type == ParentMessageType.delayTime.code ||
    //       item.type == ParentMessageType.arrivalTime.code,
    // )) {
    //   return true;
    // }

    if (any((item) => item.type == ParentMessageType.iAmHere.code)) {
      return true;
    }

    return false;
  }
}

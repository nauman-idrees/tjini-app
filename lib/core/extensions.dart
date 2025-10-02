import 'package:flutter/material.dart';
import 'package:tjini_app/core/enum.dart';

extension StringExtension on String {
  String hardcoded() {
    return this;
  }
}

extension ParentStatusExtension on ParentStatus {
  String title() {
    switch (this) {
      case ParentStatus.someoneElseIsComing:
        return "Quelqu'un d'autre vient récupérer".hardcoded();
      case ParentStatus.pickUpOnCar:
        return "Récupération en voiture".hardcoded();
      case ParentStatus.pickUpInside:
        return "Récupération à l'intérieur".hardcoded();
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

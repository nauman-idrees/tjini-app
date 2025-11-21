import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tjini_app/core/enum.dart';

import 'user.dart';

class LoginResponse {
  User? user;
  String? token;
  String message;

  LoginResponse({
    required this.user,
    required this.token,
    required this.message,
  });

  LoginResponse copyWith({
    User? user,
    String? token,
    String? message,
  }) => LoginResponse(
    user: user ?? this.user,
    token: token ?? this.token,
    message: message ?? this.message,
  );

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "message": message,
  };
}

extension LoginResponseExtension on LoginResponse {
  String? get token => this.token;
  bool get isUserDespatcherOrViewer {
    return user?.roles.any(
          (role) =>
              role.name == UserRole.dispatcher || role.name == UserRole.viewer,
        ) ??
        false;
  }
}

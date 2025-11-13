import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tjini_app/core/enum.dart';

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

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  int schoolId;
  int? isPrimary;
  String? relation;
  String? childName;
  String? deviceToken;
  DateTime createdAt;
  DateTime updatedAt;
  List<Role> roles;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.emailVerifiedAt,
    required this.schoolId,
    required this.isPrimary,
    required this.relation,
    required this.childName,
    required this.deviceToken,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    int? schoolId,
    int? isPrimary,
    String? relation,
    String? childName,
    String? deviceToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Role>? roles,
  }) => User(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    schoolId: schoolId ?? this.schoolId,
    isPrimary: isPrimary ?? this.isPrimary,
    relation: relation ?? this.relation,
    childName: childName ?? this.childName,
    deviceToken: deviceToken ?? this.deviceToken,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    roles: roles ?? this.roles,
  );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    schoolId: json["school_id"],
    isPrimary: json["is_primary"],
    relation: json["relation"],
    childName: json["child_name"],
    deviceToken: json["device_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "school_id": schoolId,
    "is_primary": isPrimary,
    "relation": relation,
    "child_name": childName,
    "device_token": deviceToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  int id;
  UserRole name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  Role copyWith({
    int? id,
    UserRole? name, // FIX: was String?
    String? guardName,
    DateTime? createdAt,
    DateTime? updatedAt,
    Pivot? pivot,
  }) => Role(
    id: id ?? this.id,
    name: name ?? this.name, // now UserRole
    guardName: guardName ?? this.guardName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    pivot: pivot ?? this.pivot,
  );

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: _parseUserRole(json["name"]), // FIX: parse to UserRole
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name.name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  String modelType;
  int modelId;
  int roleId;

  Pivot({
    required this.modelType,
    required this.modelId,
    required this.roleId,
  });

  Pivot copyWith({
    String? modelType,
    int? modelId,
    int? roleId,
  }) => Pivot(
    modelType: modelType ?? this.modelType,
    modelId: modelId ?? this.modelId,
    roleId: roleId ?? this.roleId,
  );

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelType: json["model_type"],
    modelId: json["model_id"],
    roleId: json["role_id"],
  );

  Map<String, dynamic> toJson() => {
    "model_type": modelType,
    "model_id": modelId,
    "role_id": roleId,
  };
}

UserRole _parseUserRole(Object? value) {
  if (value is String) {
    final lower = value.toLowerCase();
    for (final r in UserRole.values) {
      if (r.name.toLowerCase() == lower) return r;
    }
  }
  // Fallback: pick a sensible default or throw. Using 'viewer' as safe default.
  return UserRole.viewer;
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

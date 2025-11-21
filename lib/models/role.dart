import 'dart:convert' show json;

import 'package:tjini_app/core/enum.dart';

import 'pivot.dart';

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

  factory Role.fromMap(Map<String, dynamic> map) => Role(
    id: map["id"],
    name: _parseUserRole(map["name"]),
    guardName: map["guard_name"],
    createdAt: DateTime.parse(map["created_at"]),
    updatedAt: DateTime.parse(map["updated_at"]),
    pivot: Pivot.fromMap(map["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name.name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toMap(),
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

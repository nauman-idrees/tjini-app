import 'dart:convert';

import 'role.dart';

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
  School? school;

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
    required this.school,
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
    School? school,
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
    school: school ?? this.school,
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
    roles: json["roles"] == null
        ? []
        : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    school: json["school"] == null ? null : School.fromJson(json["school"]),
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
    "school": school?.toJson(),
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map["id"],
    firstName: map["first_name"],
    lastName: map["last_name"],
    email: map["email"],
    emailVerifiedAt: map["email_verified_at"],
    schoolId: map["school_id"],
    isPrimary: map["is_primary"],
    relation: map["relation"],
    childName: map["child_name"],
    deviceToken: map["device_token"],
    createdAt: DateTime.parse(map["created_at"]),
    updatedAt: DateTime.parse(map["updated_at"]),
    roles: map["roles"] == null
        ? []
        : List<Role>.from(map["roles"].map((x) => Role.fromMap(x))),
    school: map["school"] == null ? null : School.fromMap(map["school"]),
  );

  Map<String, dynamic> toMap() => {
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
    "roles": List<dynamic>.from(roles.map((x) => x.toMap())),
    "school": school?.toMap(),
  };
}

class School {
  final int id;
  final String name;
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;

  School({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
    id: json["id"],
    name: json["name"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  factory School.fromMap(Map<String, dynamic> map) => School(
    id: map["id"],
    name: map["name"],
    startTime: map["start_time"],
    endTime: map["end_time"],
    createdAt: map["created_at"],
    updatedAt: map["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

extension UserSchoolStatus on User {
  /// 🔵 Start Window:
  /// StartTime - 30 minutes  →  StartTime + 30 minutes
  bool get isInStartWindow {
    if (school == null) return false;
    final now = DateTime.now().subtract(Duration(hours: 4));
    final start = _parseTime(school!.startTime, now);

    final windowStart = start.subtract(const Duration(minutes: 30));
    final windowEnd = start.add(const Duration(minutes: 30));

    return now.isAfter(windowStart) && now.isBefore(windowEnd);
  }

  /// 🔴 Closing Window:
  /// EndTime - 30 minutes  →  EndTime + 2 hours
  bool get isInClosingWindow {
    if (school == null) return false;
    final now = DateTime.now().subtract(Duration(hours: 4));
    final end = _parseTime(school!.endTime, now);

    final windowStart = end.subtract(const Duration(minutes: 30));
    final windowEnd = end.add(const Duration(hours: 4));

    return now.isAfter(windowStart) && now.isBefore(windowEnd);
  }

  /// Helper: convert "HH:mm:ss" → today's DateTime
  DateTime _parseTime(String time, DateTime reference) {
    final parts = time.split(':').map(int.parse).toList();
    return DateTime(
      reference.year,
      reference.month,
      reference.day,
      parts[0],
      parts[1],
      parts.length > 2 ? parts[2] : 0,
    );
  }
}

import 'dart:convert';

List<NotificationModels> notificationModelsFromMap(String str) => List<NotificationModels>.from(json.decode(str).map((x) => NotificationModels.fromMap(x)));

String notificationModelsToMap(List<NotificationModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NotificationModels {
  int? id;
  int? fromUserId;
  String? type;
  String? message;
  String? value;
  int? schoolId;
  bool? allParents;
  String? senderRole;
  DateTime? createdAt;
  DateTime? updatedAt;
  FromUser? fromUser;

  NotificationModels({
    this.id,
    this.fromUserId,
    this.type,
    this.message,
    this.value,
    this.schoolId,
    this.allParents,
    this.senderRole,
    this.createdAt,
    this.updatedAt,
    this.fromUser,
  });

  factory NotificationModels.fromMap(Map<String, dynamic> json) => NotificationModels(
    id: json["id"],
    fromUserId: json["from_user_id"],
    type: json["type"],
    message: json["message"],
    value: json["value"],
    schoolId: json["school_id"],
    allParents: json["all_parents"],
    senderRole: json["sender_role"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fromUser: json["from_user"] == null ? null : FromUser.fromMap(json["from_user"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "from_user_id": fromUserId,
    "type": type,
    "message": message,
    "value": value,
    "school_id": schoolId,
    "all_parents": allParents,
    "sender_role": senderRole,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "from_user": fromUser?.toMap(),
  };
}

class FromUser {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  int? schoolId;
  int? isPrimary;
  String? relation;
  String? childName;
  String? deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  FromUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.schoolId,
    this.isPrimary,
    this.relation,
    this.childName,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  factory FromUser.fromMap(Map<String, dynamic> json) => FromUser(
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}


// import 'dart:convert';
//
// class NotificationModels {
//   String? type;
//   DateTime dateTime;
//   String message;
//
//   NotificationModels({
//     required this.type,
//     required this.dateTime,
//     required this.message,
//   });
//
//   factory NotificationModels.fromJson(Map<String, dynamic> json) {
//     return NotificationModels(
//       type: json["type"],
//       dateTime: DateTime.parse(json["dateTime"]),
//       message: json["message"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "type": type,
//     "dateTime": dateTime.toIso8601String(),
//     "message": message,
//   };
//
//   static List<NotificationModels> listFromJson(String jsonString) {
//     final List decoded = json.decode(jsonString);
//     return decoded.map((e) => NotificationModels.fromJson(e)).toList();
//   }
//
//   static String listToJson(List<NotificationModels> list) {
//     return json.encode(list.map((e) => e.toJson()).toList());
//   }
// }

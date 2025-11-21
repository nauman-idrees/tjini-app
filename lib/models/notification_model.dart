import 'dart:convert';

import 'user.dart';

List<NotificationItem> notificationModelsFromMap(String str) =>
    List<NotificationItem>.from(
      json.decode(str).map((x) => NotificationItem.fromMap(x)),
    );

String notificationModelsToMap(List<NotificationItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NotificationItem {
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
  User? fromUser;
  User? toUser;

  NotificationItem({
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
    this.toUser,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> json) =>
      NotificationItem(
        id: json["id"],
        fromUserId: json["from_user_id"],
        type: json["type"],
        message: json["message"],
        value: json["value"],
        schoolId: json["school_id"],
        allParents: json["all_parents"],
        senderRole: json["sender_role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fromUser: json["from_user"] == null
            ? null
            : User.fromMap(json["from_user"]),
        toUser: json["to_user"] == null ? null : User.fromMap(json["to_user"]),
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
    "to_user": toUser?.toMap(),
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

import 'dart:convert';

class NotificationModels {
  String? type;
  DateTime dateTime;
  String message;

  NotificationModels({
    required this.type,
    required this.dateTime,
    required this.message,
  });

  factory NotificationModels.fromJson(Map<String, dynamic> json) {
    return NotificationModels(
      type: json["type"],
      dateTime: DateTime.parse(json["dateTime"]),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "dateTime": dateTime.toIso8601String(),
    "message": message,
  };

  static List<NotificationModels> listFromJson(String jsonString) {
    final List decoded = json.decode(jsonString);
    return decoded.map((e) => NotificationModels.fromJson(e)).toList();
  }

  static String listToJson(List<NotificationModels> list) {
    return json.encode(list.map((e) => e.toJson()).toList());
  }
}

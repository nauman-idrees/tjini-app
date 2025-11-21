import 'user.dart';

class DispatcheeModel {
  final int id;
  final int userId;
  final String type;
  final int time;
  final String? status;
  final int schoolId;
  final String createdAt;
  final String updatedAt;
  final User user;

  DispatcheeModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.time,
    this.status,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory DispatcheeModel.fromJson(Map<String, dynamic> json) {
    return DispatcheeModel(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      time: json['time'],
      status: json['status'],
      schoolId: json['school_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'time': time,
      'status': status,
      'school_id': schoolId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user.toJson(),
    };
  }
}

List<DispatcheeModel> dispatcheeModelListFromJson(List<dynamic> data) {
  return data.map((e) => DispatcheeModel.fromJson(e)).toList();
}

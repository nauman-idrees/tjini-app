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

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int schoolId;
  final int isPrimary;
  final int? primaryParentId;
  final String relation;
  final String childName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.schoolId,
    required this.isPrimary,
    this.primaryParentId,
    required this.relation,
    required this.childName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      schoolId: json['school_id'],
      isPrimary: json['is_primary'],
      primaryParentId: json['primary_parent_id'],
      relation: json['relation'],
      childName: json['child_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'school_id': schoolId,
      'is_primary': isPrimary,
      'primary_parent_id': primaryParentId,
      'relation': relation,
      'child_name': childName,
    };
  }
}

List<DispatcheeModel> dispatcheeModelListFromJson(List<dynamic> data) {
  return data.map((e) => DispatcheeModel.fromJson(e)).toList();
}

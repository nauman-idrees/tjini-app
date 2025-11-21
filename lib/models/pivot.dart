import 'dart:convert';

import 'package:tjini_app/core/enum.dart';

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
  factory Pivot.fromMap(Map<String, dynamic> map) => Pivot(
    modelType: map["model_type"],
    modelId: map["model_id"],
    roleId: map["role_id"],
  );

  Map<String, dynamic> toMap() => {
    "model_type": modelType,
    "model_id": modelId,
    "role_id": roleId,
  };
}

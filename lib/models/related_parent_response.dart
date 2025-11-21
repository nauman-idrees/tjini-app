import 'login_response.dart';
import 'user.dart';

class RelatedParentResponse {
  final User primary;
  final List<User> secondaries;

  RelatedParentResponse({
    required this.primary,
    required this.secondaries,
  });

  factory RelatedParentResponse.fromJson(Map<String, dynamic> json) {
    return RelatedParentResponse(
      primary: User.fromJson(json['primary']),
      secondaries: (json['secondaries'] as List)
          .map((e) => User.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primary': primary.toJson(),
      'secondaries': secondaries.map((e) => e.toJson()).toList(),
    };
  }

  /// 🔥 Mix primary + secondary into one list
  List<User> get allParents => [primary, ...secondaries];
}

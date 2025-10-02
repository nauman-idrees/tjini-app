import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/login_response.dart';

abstract class IRemoteRepository {
  Future<Result<AuthResponse, CustomException>> login({
    required String email,
    required String password,
    required String token,
  });

  Future<Result<AuthResponse, CustomException>> resetPassword({
    required String email,
    required String password,
  });
}

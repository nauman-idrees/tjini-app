import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/login_response.dart';

abstract class IRemoteRepository {
  Future<Result<LoginResponse, CustomException>> login({
    required String email,
    required String password,
    String? token,
  });

  Future<Result<LoginResponse, CustomException>> resetPassword({
    required String email,
    required String password,
  });
}

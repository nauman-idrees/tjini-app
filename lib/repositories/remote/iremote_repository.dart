import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/dispatchee_model.dart';
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

  Future<Result<List<DispatcheeModel>, CustomException>> getDispatchees();
  Future<Result<void, CustomException>> sendParentNotification({
    required String type,
    required String message,
    required int fromUserId,
    int? toUserId,
  });
}

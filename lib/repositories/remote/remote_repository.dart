import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/core/apis/api_endpoints.dart';
import 'package:tjini_app/core/apis/api_service.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/dispatchee_model.dart';
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/repositories/remote/iremote_repository.dart';

class RemoteRepository implements IRemoteRepository {
  @override
  Future<Result<LoginResponse, CustomException>> login({
    required String email,
    required String password,
    String? token,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      if (token != null) {
        data["device_token"] = token;
      }
      final response = await ApiService().postRequest(
        ApiEndpoints.login,
        data,
      );
      return Result.success(
        LoginResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<LoginResponse, CustomException>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService().postRequest(
        ApiEndpoints.resetPassword,
        {
          "email": email,
          "password": password,
          "password_confirmation": password,
        },
      );
      return Result.success(
        LoginResponse.fromJson(response.data as Map<String, dynamic>),
      );
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<List<DispatcheeModel>, CustomException>>
  getDispatchees() async {
    try {
      final response = await ApiService().getRequest(
        ApiEndpoints.dispatcheeList,
      );
      return Result.success(
        dispatcheeModelListFromJson(response.data as List<dynamic>),
      );
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<bool, CustomException>> sendParentNotification({
    required String type,
    required String message,
    required int fromUserId,
    int? toUserId,
  }) async {
    try {
      await ApiService().postRequest(
        ApiEndpoints.notify,
        {
          'type': type,
          'message': message,
          'fromUserId': fromUserId,
          if (toUserId != null) 'toUserId': toUserId,
        },
      );
      return Result.success(true);
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }
}

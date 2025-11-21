import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/core/apis/api_endpoints.dart';
import 'package:tjini_app/core/apis/api_service.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/dispatchee_model.dart' hide User;
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/models/notification_model.dart' hide User;
import 'package:tjini_app/models/related_parent_response.dart'
    show RelatedParentResponse;
import 'package:tjini_app/repositories/remote/iremote_repository.dart';

import '../../models/user.dart';

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
  Future<Result<bool, CustomException>> sendNotification({
    required String type,
    required String message,
    required int fromUserId,
    int? toUserId,
    int? value,
  }) async {
    try {
      final response = await ApiService().postRequest(
        ApiEndpoints.notify,
        {
          'type': type,
          'message': message,
          'fromUserId': fromUserId,
          if (toUserId != null) 'toUserId': toUserId,
          if (value != null) 'value': value,
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

  @override
  Future<Result<List<NotificationItem>, CustomException>>
  getNotifications() async {
    try {
      final response = await ApiService().getRequest(
        ApiEndpoints.notification,
      );

      List<NotificationItem> _latestNotification = [];

      if (response.statusCode == 200) {
        for (dynamic data in response.data) {
          _latestNotification.add(NotificationItem.fromMap(data));
        }
      }
      return Result.success(_latestNotification);
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<List<User>, CustomException>> getRelatedParents({
    required int userId,
  }) async {
    try {
      final response = await ApiService().postRequest(
        ApiEndpoints.relatedParents,
        {
          'userId': userId,
        },
      );
      RelatedParentResponse relatedParentResponse =
          RelatedParentResponse.fromJson(
            response.data as Map<String, dynamic>,
          );
      return Result.success(relatedParentResponse.allParents);
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Future.value(Result.error(CustomException(message: e.message)));
    } on Exception catch (e) {
      return Future.value(Result.error(CustomException(message: e.toString())));
    }
  }

  @override
  Future<Result<List<NotificationItem>, CustomException>>
  getTransferNotification() async {
    try {
      final response = await ApiService().getRequest(
        ApiEndpoints.transferNotifications,
      );

      List<NotificationItem> _latestNotification = [];

      if (response.statusCode == 200) {
        for (dynamic data in response.data) {
          _latestNotification.add(NotificationItem.fromMap(data));
        }
      }
      return Result.success(_latestNotification);
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }

  @override
  Future<Result<bool, CustomException>> updateDispatcheeStatus({
    required int parentId,
    required String status,
  }) async {
    try {
      await ApiService().postRequest(
        ApiEndpoints.updateDispatchee,
        {
          'parent_id': parentId,
          'status': status,
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

  @override
  Future<Result<bool, CustomException>> updateDispatcheeTime({
    int? parentId,
    required int time,
  }) async {
    try {
      await ApiService().postRequest(
        ApiEndpoints.updateDispatchee,
        {
          if (parentId != null) 'parent_id': parentId,
          'value': time,
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

  @override
  Future<Result<bool, CustomException>> logout() async {
    try {
      await ApiService().postRequest(ApiEndpoints.logout, null);
      return Result.success(true);
    } on CustomException catch (e) {
      // ExceptionHandler.handleException(e);
      return Result.error(CustomException(message: e.message));
    } on Exception catch (e) {
      return Result.error(CustomException(message: e.toString()));
    }
  }
}

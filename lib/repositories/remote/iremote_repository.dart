import 'package:multiple_result/multiple_result.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'package:tjini_app/models/dispatchee_model.dart' hide User;
import 'package:tjini_app/models/login_response.dart';
import 'package:tjini_app/models/notification_model.dart' hide User;

import '../../models/user.dart';

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
  Future<Result<void, CustomException>> sendNotification({
    required String type,
    required String message,
    required int fromUserId,
    int? toUserId,
    int? value,
  });

  Future<Result<List<NotificationItem>, CustomException>> getNotifications();
  Future<Result<List<User>, CustomException>> getRelatedParents({
    required int userId,
  });

  Future<Result<List<NotificationItem>, CustomException>>
  getTransferNotification();

  Future<Result<bool, CustomException>> updateDispatcheeStatus({
    required int parentId,
    required String status,
  });

  Future<Result<bool, CustomException>> updateDispatcheeTime({
    int? parentId,
    required int time,
  });

  Future<Result<bool, CustomException>> logout();
}

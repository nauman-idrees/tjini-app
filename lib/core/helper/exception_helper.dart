import 'package:dio/dio.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/core/utils/toast_utils.dart';

class ExceptionHandler {
  static void handleException(
    Exception e, {
    bool isShowToast = true,
    String? errorMessage,
  }) {
    String errorMsg = "";
    if (e is DioException) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        errorMsg =
            "Délai d’attente dépassé. Veuillez vérifier votre connexion et réessayer.";
      } else if (e.type == DioExceptionType.connectionError) {
        errorMsg =
            "Impossible de se connecter. Vérifiez votre connexion Internet.";
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode != null) {
          if (e.response!.statusCode! >= 400 && e.response!.statusCode! < 500) {
            errorMsg =
                errorMessage ??
                "Quelque chose s’est mal passé. Veuillez réessayer.";
          }
          if (e.response!.statusCode! >= 500 && e.response!.statusCode! < 600) {
            errorMsg =
                "Une erreur inattendue s’est produite. Veuillez réessayer.";
          }
        } else {
          errorMsg = "Quelque chose s’est mal passé. Veuillez réessayer.";
        }
      } else {
        errorMsg = "Une erreur inattendue s’est produite. Veuillez réessayer.";
      }
    } else {
      errorMsg = "Quelque chose s’est mal passé. Veuillez réessayer.";
    }
    if (isShowToast) {
      ToastUtils.show(msg: errorMsg, type: ToastType.error);
    }
  }
}

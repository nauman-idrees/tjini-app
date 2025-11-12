import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tjini_app/models/cutom_exception.dart';
import 'api_endpoints.dart';

class ApiService {
  final Dio _dio;
  final bool _isSessionDialogShowing = false;

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
        ),
      ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // String? accessToken =
          //     locator<SharedPreferencesHelper>().getAccessToken();
          // if (accessToken != null) {
          //   options.headers['Authorization'] =
          //       'Bearer ${locator<SharedPreferencesHelper>().getAccessToken()}';
          // }
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data if needed
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          // Handle errors
          if (e.response?.statusCode == 401 && !_isSessionDialogShowing) {
            // await logoutAndClearSession();
          }
          return handler.next(e); //continue
        },
      ),
    );
    _dio.interceptors.add(PrettyDioLogger(requestBody: true, request: true));
  }

  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> postRequest(
    String endpoint,
    Map<String, dynamic>? data,
  ) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> deleteRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> putRequest(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleResponse(Response response) {
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 400) {
      throw Exception('Failed to connect to the API: ${response.data}');
    }
  }

  void _handleError(DioException error) {
    String errorDescription = '';
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      errorDescription = "Connection Timeout Exception";
    } else if (error.type == DioExceptionType.badResponse) {
      String? message = error.response?.data?["message"] as String?;

      errorDescription =
          message ??
          "Received Invalid Status Code: ${error.response?.statusCode}";
    } else {
      errorDescription = "Unexpected Error: ${error.message}";
    }
    throw CustomException(message: errorDescription);
  }

  Future<Response> sendNotification(
      String endpoint,
      Map<String, dynamic> data,
      String token,
      ) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> getNotification(
      String endpoint,
      String token,
      ) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      _handleResponse(response);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }


}

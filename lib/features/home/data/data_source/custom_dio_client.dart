import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10), // 10 seconds
      receiveTimeout: const Duration(seconds: 10), // 10 seconds
      sendTimeout: const Duration(seconds: 10), // 10 seconds
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ));

    // Add interceptors
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Check if the request requires a token
          if (options.extra["requiresToken"] == true) {
            final token = getIt<SharedPreferences>().getString("token");
            if (token != null) {
              options.headers["Authorization"] =
                  "Bearer $token"; // Add token to headers
            }
          }

          // Log headers and other request info in debug mode
          if (kDebugMode) {
            log("Headers: ${options.headers}");
            log("Data: ${options.data}");
          }

          return handler.next(options); // continue the request
        },
        onResponse: (response, handler) {
          // Process the response
          return handler.next(response); // continue the response handling
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // Handle Timeout errors
          log(e.message.toString());

          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            throw TimeoutException(
                "The connection has timed out, please try again.");
          }

          // Handle 401 Unauthorized error
          if (e.response?.statusCode == 401) {
            log(e.response!.statusCode.toString());
       
          }

          return handler.next(e); // continue the error handling
        },
      ),

      // Retry Interceptor for retrying failed requests
      RetryInterceptor(
        dio: _dio,
        retries: 3, // Number of retry attempts
        retryDelays: [
          const Duration(seconds: 1),
          const Duration(seconds: 2),
          const Duration(seconds: 3)
        ], // Delays between retries
      ),

      // Log Interceptor for Debug mode
      if (kDebugMode)
        LogInterceptor(
          responseBody: true, // Log response body for debugging
          requestBody: true, // Log request body for debugging
        ),
    ]);
  }

  Dio get dio => _dio;
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final List<Duration> retryDelays;

  RetryInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3)
    ],
  });

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err) && retries > 0) {
      // Wait for retry delay
      final retryAttempt = retries - retryDelays.length + 1;
      if (retryAttempt < retryDelays.length) {
        await Future.delayed(retryDelays[retryAttempt]);
      }

      try {
        // Retry the request
        final response = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
            extra: err.requestOptions.extra,
          ),
        );
        return handler.resolve(response);
      } catch (e) {
        // Continue throwing error if retries exhausted
        return handler.next(err);
      }
    }

    return super.onError(err, handler); // Continue if no retry
  }

  bool _shouldRetry(DioException err) {
    return err.type != DioExceptionType.cancel &&
        err.type !=
            DioExceptionType
                .badResponse; // Check for bad responses instead of 'other'
  }
}

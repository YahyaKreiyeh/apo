import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/core/networking/api_error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static String? _authToken;
  static String _acceptLanguage = 'en';

  static void setAuthToken(String? token) {
    _authToken = (token != null && token.isNotEmpty) ? token : null;
  }

  static void setAcceptLanguage(String? languageTag) {
    if (languageTag == null || languageTag.trim().isEmpty) return;
    _acceptLanguage = languageTag;
  }

  static Dio create({String? acceptLanguage}) {
    setAcceptLanguage(acceptLanguage);

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'content-type': 'application/json',
          'Accept-Language': _acceptLanguage,
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          } else {
            options.headers.remove('Authorization');
          }
          options.headers['Accept-Language'] = _acceptLanguage;
          handler.next(options);
        },
        onResponse: (response, handler) {
          final apiError = ApiErrorHandler.tryParseServerErrorPayload(
            response.data,
          );
          if (apiError != null && apiError.indicatesFailure) {
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                type: DioExceptionType.badResponse,
                error: apiError,
              ),
            );
          }
          handler.next(response);
        },
        onError: (e, handler) {
          final apiError = ApiErrorHandler.handle(e);
          handler.reject(e.copyWith(error: apiError));
        },
      ),
    );

    if (kDebugMode && dio.interceptors.whereType<PrettyDioLogger>().isEmpty) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
    }

    return dio;
  }
}

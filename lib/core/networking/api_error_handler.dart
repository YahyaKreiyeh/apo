import 'dart:io';

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:dio/dio.dart';

class ApiErrorHandler {
  const ApiErrorHandler._();

  static ApiError handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          if (error.error is SocketException || error.response == null) {
            return ApiError(
              ApiErrorType.network,
              message: AppStrings.connectionError,
            );
          }
          return _fromStatus(error.response?.statusCode, error.response?.data);

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiError(
            ApiErrorType.requestTimeout,
            message: AppStrings.connectionError,
          );

        case DioExceptionType.cancel:
          return ApiError(
            ApiErrorType.cancelled,
            message: AppStrings.unknownError,
          );

        case DioExceptionType.badCertificate:
          return ApiError(
            ApiErrorType.badGateway,
            message: AppStrings.unknownError,
          );

        case DioExceptionType.badResponse:
          return _fromStatus(error.response?.statusCode, error.response?.data);
      }
    }
    return ApiError(ApiErrorType.unexpected, message: AppStrings.unknownError);
  }

  static ApiErrorModel handleToModel(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode ?? 500;
      final data = error.response?.data;

      final mappedError = tryParseServerErrorPayload(data);
      if (mappedError != null) {
        return mappedError;
      }

      final apiError = handle(error);
      return ApiErrorModel(
        status: statusCode,
        title: apiError.message ?? AppStrings.unknownError,
      );
    }

    return ApiErrorModel(status: 500, title: AppStrings.unknownError);
  }

  static ApiErrorModel? tryParseServerErrorPayload(dynamic data) {
    final payload = _extractServerErrorPayload(data);
    if (payload is Map<String, dynamic>) {
      try {
        final errorModel = ApiErrorModel.fromJson(payload);
        if (errorModel.indicatesFailure ||
            payload.containsKey('errors') ||
            payload.containsKey('Errors')) {
          return errorModel;
        }
      } catch (_) {}
    }
    return null;
  }

  static ApiError _fromStatus(int? status, dynamic data) {
    final msg = _normalizeErrorMessage(_extractServerErrorPayload(data));
    switch (status) {
      case 400:
      case 402:
      case 405:
      case 422:
        return ApiError(ApiErrorType.badRequest, message: msg);
      case 401:
        return ApiError(ApiErrorType.unauthorized, message: msg);
      case 403:
        return ApiError(ApiErrorType.forbidden, message: msg);
      case 404:
        return ApiError(ApiErrorType.notFound, message: msg);
      case 408:
        return ApiError(ApiErrorType.requestTimeout, message: msg);
      case 409:
        return ApiError(ApiErrorType.conflict, message: msg);
      case 500:
        return ApiError(ApiErrorType.internalServer, message: msg);
      case 502:
        return ApiError(ApiErrorType.badGateway, message: msg);
      default:
        return ApiError(ApiErrorType.unexpected, message: msg);
    }
  }

  static String _normalizeErrorMessage(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      try {
        final model = ApiErrorModel.fromJson(payload);

        final fromValidation = model.firstErrorMessage();
        if (fromValidation != null && fromValidation.isNotEmpty) {
          return fromValidation;
        }

        if (model.title != null && model.title!.isNotEmpty) {
          return model.title!;
        }

        if (model.message != null && model.message!.isNotEmpty) {
          return model.message!;
        }
      } catch (_) {}
    }

    return AppStrings.unknownError;
  }

  static dynamic _extractServerErrorPayload(dynamic raw) {
    return raw;
  }
}

enum ApiErrorType {
  network,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  requestTimeout,
  conflict,
  internalServer,
  badGateway,
  cancelled,
  unexpected,
  custom,
}

class ApiError implements Exception {
  final ApiErrorType type;
  final String? message;
  ApiError(this.type, {this.message});
}

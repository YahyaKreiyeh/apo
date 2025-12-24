import 'dart:async';

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/helpers/preferences_helper.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/networking/api_error_handler.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:apo/core/networking/dio_factory.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/routing/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRepository {
  Future<ApiResponseModel<T>> executeApiCall<T, R>({
    required Future<R> Function() apiCall,
    required T Function(R response) mapper,
    void Function(T data)? onSuccess,
    void Function(ApiErrorModel error)? onError,
    void Function()? onComplete,
  }) async {
    try {
      final response = await apiCall();
      final mappedData = mapper(response);

      onSuccess?.call(mappedData);

      return ApiResponseModel.success(mappedData);
    } on DioException catch (e) {
      final errorModel = ApiErrorHandler.handleToModel(e);

      onError?.call(errorModel);

      _handleAuthErrors(errorModel);

      return ApiResponseModel.failure(errorModel);
    } catch (e) {
      final errorModel = ApiErrorModel(
        status: 500,
        title: AppStrings.unknownError,
      );

      onError?.call(errorModel);

      return ApiResponseModel.failure(errorModel);
    } finally {
      onComplete?.call();
    }
  }

  Future<ApiResponseModel<void>> executeVoidApiCall({
    required Future<void> Function() apiCall,
    void Function()? onSuccess,
    void Function(ApiErrorModel error)? onError,
    void Function()? onComplete,
    bool enableLogging = kDebugMode,
  }) async {
    try {
      await apiCall();

      onSuccess?.call();

      return const ApiResponseModel.success(null);
    } on DioException catch (e) {
      final errorModel = ApiErrorHandler.handleToModel(e);

      onError?.call(errorModel);

      _handleAuthErrors(errorModel);

      return ApiResponseModel.failure(errorModel);
    } catch (e) {
      final errorModel = ApiErrorModel(
        status: 500,
        title: AppStrings.unknownError,
      );

      onError?.call(errorModel);

      return ApiResponseModel.failure(errorModel);
    } finally {
      onComplete?.call();
    }
  }

  void _handleAuthErrors(ApiErrorModel error) {
    final status = error.status;

    if (status == 403) {
      unawaited(clearSession());
    }
  }

  static Future<void> clearSession() async {
    DioFactory.setAuthToken(null);
    await PreferencesHelper.clear();
    await SecureStorageHelper.clear();
    navigatorKey.currentContext?.goNamed(RouteNames.home.name);
  }
}

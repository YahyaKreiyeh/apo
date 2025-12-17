import 'package:apo/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_model.freezed.dart';

@freezed
class ApiResponseModel<T> with _$ApiResponseModel<T> {
  const factory ApiResponseModel.success(T data) = Success<T>;
  const factory ApiResponseModel.failure(ApiErrorModel apiErrorModel) =
      Failure<T>;
}

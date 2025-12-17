import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.empty() = Empty<T>;
  const factory Result.loading() = Loading<T>;
  const factory Result.success({required T data}) = Success<T>;
  const factory Result.failure({required ApiErrorModel error, T? data}) =
      Failure<T>;
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => switch (this) {
    Success() => true,
    _ => false,
  };

  bool get isLoading => switch (this) {
    Loading() => true,
    _ => false,
  };

  bool get isFailure => switch (this) {
    Failure() => true,
    _ => false,
  };

  T? get successValue => switch (this) {
    Success(data: final d) => d,
    _ => null,
  };

  T? get failureValue => switch (this) {
    Failure(data: final d) => d,
    _ => null,
  };

  ApiErrorModel? get failureError => switch (this) {
    Failure(error: final e) => e,
    _ => null,
  };

  String get failureMessage => switch (this) {
    Failure(error: final e) => e.messageOrDefault,
    _ => AppStrings.unknownError,
  };
}

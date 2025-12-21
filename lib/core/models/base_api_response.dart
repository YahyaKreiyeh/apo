import 'package:json_annotation/json_annotation.dart';

part 'base_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseApiResponse<T> {
  final String? message;
  final String? error;
  final int httpStatus;
  final bool success;
  final T? data;
  const BaseApiResponse({
    required this.message,
    required this.error,
    required this.httpStatus,
    required this.success,
    this.data,
  });

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseApiResponseToJson(this, toJsonT);
}

import 'package:json_annotation/json_annotation.dart';

part 'base_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseApiResponse<T> {
  @JsonKey(name: 'Status')
  final bool status;
  @JsonKey(name: 'Code')
  final int code;
  @JsonKey(name: 'Data')
  final T? data;
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'TotalCount')
  final int? totalCount;
  const BaseApiResponse({
    required this.status,
    required this.code,
    this.data,
    this.message,
    this.totalCount,
  });

  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseApiResponseToJson(this, toJsonT);
}

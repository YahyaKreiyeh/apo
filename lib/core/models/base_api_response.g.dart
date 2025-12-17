// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiResponse<T> _$BaseApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BaseApiResponse<T>(
  status: json['Status'] as bool,
  code: (json['Code'] as num).toInt(),
  data: _$nullableGenericFromJson(json['Data'], fromJsonT),
  message: json['Message'] as String?,
  totalCount: (json['TotalCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$BaseApiResponseToJson<T>(
  BaseApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'Status': instance.status,
  'Code': instance.code,
  'Data': _$nullableGenericToJson(instance.data, toJsonT),
  'Message': instance.message,
  'TotalCount': instance.totalCount,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

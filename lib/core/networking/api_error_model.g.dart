// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: (json['status'] as num?)?.toInt(),
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      traceId: json['traceId'] as String?,
      message: json['Message'] as String?,
      code: (json['Code'] as num?)?.toInt(),
      responseStatus: json['Status'] as bool?,
      data: json['Data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'status': instance.status,
      'errors': instance.errors,
      'traceId': instance.traceId,
      'Message': instance.message,
      'Code': instance.code,
      'Status': instance.responseStatus,
      'Data': instance.data,
    };

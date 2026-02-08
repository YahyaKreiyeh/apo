// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationCreateResponseModel _$DecorationCreateResponseModelFromJson(
  Map<String, dynamic> json,
) => DecorationCreateResponseModel(
  decorationId: (json['decorationId'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$DecorationCreateResponseModelToJson(
  DecorationCreateResponseModel instance,
) => <String, dynamic>{
  'decorationId': instance.decorationId,
  'id': instance.id,
};

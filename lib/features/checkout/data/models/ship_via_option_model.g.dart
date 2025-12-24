// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_via_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipViaOptionModel _$ShipViaOptionModelFromJson(Map<String, dynamic> json) =>
    ShipViaOptionModel(
      id: (json['masterDetailId'] as num).toInt(),
      detailName: json['detailName'] as String,
      detailCode: json['detailCode'] as String,
      displayOrder: (json['displayOrder'] as num).toInt(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$ShipViaOptionModelToJson(ShipViaOptionModel instance) =>
    <String, dynamic>{
      'masterDetailId': instance.id,
      'detailName': instance.detailName,
      'detailCode': instance.detailCode,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };

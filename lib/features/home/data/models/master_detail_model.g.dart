// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDetailModel _$MasterDetailModelFromJson(Map<String, dynamic> json) =>
    MasterDetailModel(
      id: (json['masterDetailId'] as num).toInt(),
      detailName: json['detailName'] as String,
      detailCode: json['detailCode'] as String,
      displayOrder: (json['displayOrder'] as num).toInt(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$MasterDetailModelToJson(MasterDetailModel instance) =>
    <String, dynamic>{
      'masterDetailId': instance.id,
      'detailName': instance.detailName,
      'detailCode': instance.detailCode,
      'displayOrder': instance.displayOrder,
      'isActive': instance.isActive,
    };

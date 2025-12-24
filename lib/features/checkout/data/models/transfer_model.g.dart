// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferModel _$TransferModelFromJson(Map<String, dynamic> json) =>
    TransferModel(
      transferId: (json['transferId'] as num).toInt(),
      transferType: json['transferType'] as String,
      transferTypeId: (json['transferTypeId'] as num).toInt(),
      sheetTypeId: (json['sheetTypeId'] as num).toInt(),
      transferCatalogId: (json['transferCatalogId'] as num).toInt(),
      transferCode: json['transferCode'] as String,
      transferName: json['transferName'] as String,
      artworkUrl: json['artworkUrl'] as String,
      artworkThumbnailUrl: json['artworkThumbnailUrl'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TransferModelToJson(TransferModel instance) =>
    <String, dynamic>{
      'transferId': instance.transferId,
      'transferType': instance.transferType,
      'transferTypeId': instance.transferTypeId,
      'sheetTypeId': instance.sheetTypeId,
      'transferCatalogId': instance.transferCatalogId,
      'transferCode': instance.transferCode,
      'transferName': instance.transferName,
      'artworkUrl': instance.artworkUrl,
      'artworkThumbnailUrl': instance.artworkThumbnailUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

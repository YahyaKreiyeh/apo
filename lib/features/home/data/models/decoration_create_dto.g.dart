// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decoration_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecorationCreateDto _$DecorationCreateDtoFromJson(Map<String, dynamic> json) =>
    DecorationCreateDto(
      decorationName: json['decorationName'] as String,
      decorationType: json['decorationType'] as String,
      decorationTypeId: (json['decorationTypeId'] as num).toInt(),
      embOptionsId: (json['embOptionsId'] as num?)?.toInt(),
      embTypeId: (json['embTypeId'] as num?)?.toInt(),
      heatTransferTypeId: (json['heatTransferTypeId'] as num?)?.toInt(),
      heatTransferWidth: json['heatTransferWidth'] as num?,
      heatTransferHeight: json['heatTransferHeight'] as num?,
      screenPrintColorsId: (json['screenPrintColorsId'] as num?)?.toInt(),
      screenPrintGarmentTypeId: (json['screenPrintGarmentTypeId'] as num?)
          ?.toInt(),
      screenPrintLocationId: (json['screenPrintLocationId'] as num?)?.toInt(),
      leatherColorId: (json['leatherColorId'] as num?)?.toInt(),
      leatherWidth: json['leatherWidth'] as num?,
      leatherHeight: json['leatherHeight'] as num?,
      patchesTypeId: (json['patchesTypeId'] as num?)?.toInt(),
      patchesWidth: json['patchesWidth'] as num?,
      patchesHeight: json['patchesHeight'] as num?,
      labelsTypeId: (json['labelsTypeId'] as num?)?.toInt(),
      labelsWidth: json['labelsWidth'] as num?,
      labelsHeight: json['labelsHeight'] as num?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$DecorationCreateDtoToJson(
  DecorationCreateDto instance,
) => <String, dynamic>{
  'decorationName': instance.decorationName,
  'decorationType': instance.decorationType,
  'decorationTypeId': instance.decorationTypeId,
  'embOptionsId': ?instance.embOptionsId,
  'embTypeId': ?instance.embTypeId,
  'heatTransferTypeId': ?instance.heatTransferTypeId,
  'heatTransferWidth': ?instance.heatTransferWidth,
  'heatTransferHeight': ?instance.heatTransferHeight,
  'screenPrintColorsId': ?instance.screenPrintColorsId,
  'screenPrintGarmentTypeId': ?instance.screenPrintGarmentTypeId,
  'screenPrintLocationId': ?instance.screenPrintLocationId,
  'leatherColorId': ?instance.leatherColorId,
  'leatherWidth': ?instance.leatherWidth,
  'leatherHeight': ?instance.leatherHeight,
  'patchesTypeId': ?instance.patchesTypeId,
  'patchesWidth': ?instance.patchesWidth,
  'patchesHeight': ?instance.patchesHeight,
  'labelsTypeId': ?instance.labelsTypeId,
  'labelsWidth': ?instance.labelsWidth,
  'labelsHeight': ?instance.labelsHeight,
  'imageUrl': ?instance.imageUrl,
};

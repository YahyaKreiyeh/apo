import 'package:json_annotation/json_annotation.dart';

part 'decoration_create_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class DecorationCreateDto {
  final String decorationName;
  final String decorationType;
  final int decorationTypeId;
  final int? embOptionsId;
  final int? embTypeId;
  final int? heatTransferTypeId;
  final num? heatTransferWidth;
  final num? heatTransferHeight;
  final int? screenPrintColorsId;
  final int? screenPrintGarmentTypeId;
  final int? screenPrintLocationId;
  final int? leatherColorId;
  final num? leatherWidth;
  final num? leatherHeight;
  final int? patchesTypeId;
  final num? patchesWidth;
  final num? patchesHeight;
  final int? labelsTypeId;
  final num? labelsWidth;
  final num? labelsHeight;
  final String? imageUrl;

  const DecorationCreateDto({
    required this.decorationName,
    required this.decorationType,
    required this.decorationTypeId,
    this.embOptionsId,
    this.embTypeId,
    this.heatTransferTypeId,
    this.heatTransferWidth,
    this.heatTransferHeight,
    this.screenPrintColorsId,
    this.screenPrintGarmentTypeId,
    this.screenPrintLocationId,
    this.leatherColorId,
    this.leatherWidth,
    this.leatherHeight,
    this.patchesTypeId,
    this.patchesWidth,
    this.patchesHeight,
    this.labelsTypeId,
    this.labelsWidth,
    this.labelsHeight,
    this.imageUrl,
  });

  factory DecorationCreateDto.fromJson(Map<String, dynamic> json) =>
      _$DecorationCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DecorationCreateDtoToJson(this);
}

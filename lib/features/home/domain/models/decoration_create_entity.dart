class DecorationCreateEntity {
  final String decorationName;
  final String decorationType;
  final int decorationTypeId;
  final int? embOptionsId;
  final int? embTypeId;
  final int? heatTransferTypeId;
  final double? heatTransferWidth;
  final double? heatTransferHeight;
  final int? screenPrintColorsId;
  final int? screenPrintGarmentTypeId;
  final int? screenPrintLocationId;
  final int? leatherColorId;
  final double? leatherWidth;
  final double? leatherHeight;
  final int? patchesTypeId;
  final double? patchesWidth;
  final double? patchesHeight;
  final int? labelsTypeId;
  final double? labelsWidth;
  final double? labelsHeight;
  final String? imageUrl;

  const DecorationCreateEntity({
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
}

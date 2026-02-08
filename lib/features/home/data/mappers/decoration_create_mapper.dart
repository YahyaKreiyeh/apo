import 'package:apo/features/home/data/models/decoration_create_dto.dart';
import 'package:apo/features/home/domain/models/decoration_create_entity.dart';

extension DecorationCreateEntityMapper on DecorationCreateEntity? {
  DecorationCreateDto toDto() {
    return DecorationCreateDto(
      decorationName: this?.decorationName ?? '',
      decorationType: this?.decorationType ?? '',
      decorationTypeId: this?.decorationTypeId ?? 0,
      embOptionsId: this?.embOptionsId,
      embTypeId: this?.embTypeId,
      heatTransferTypeId: this?.heatTransferTypeId,
      heatTransferWidth: this?.heatTransferWidth,
      heatTransferHeight: this?.heatTransferHeight,
      screenPrintColorsId: this?.screenPrintColorsId,
      screenPrintGarmentTypeId: this?.screenPrintGarmentTypeId,
      screenPrintLocationId: this?.screenPrintLocationId,
      leatherColorId: this?.leatherColorId,
      leatherWidth: this?.leatherWidth,
      leatherHeight: this?.leatherHeight,
      patchesTypeId: this?.patchesTypeId,
      patchesWidth: this?.patchesWidth,
      patchesHeight: this?.patchesHeight,
      labelsTypeId: this?.labelsTypeId,
      labelsWidth: this?.labelsWidth,
      labelsHeight: this?.labelsHeight,
      imageUrl: this?.imageUrl,
    );
  }
}

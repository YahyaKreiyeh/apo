enum MasterDetailType {
  decorationType,
  embOptions,
  embType,
  heatTransferType,
  screenPrintColor,
  screenPrintGarment,
  screenPrintLocation,
  leatherColor,
  patchType,
  labelType,
  embroideryDecoration,
  heatTransferDecoration,
  screenPrintDecoration,
  leatherDecoration,
  patchesDecoration,
  labelsDecoration,
}

extension MasterDetailTypeX on MasterDetailType {
  static MasterDetailType? fromDetailCode(String? code) {
    if (code == null) return null;
    switch (code.toUpperCase()) {
      case 'EMBROIDERY':
        return MasterDetailType.embroideryDecoration;
      case 'HEAT_TRANSFER':
        return MasterDetailType.heatTransferDecoration;
      case 'SCREEN_PRINT':
        return MasterDetailType.screenPrintDecoration;
      case 'LEATHER':
        return MasterDetailType.leatherDecoration;
      case 'PATCHES':
        return MasterDetailType.patchesDecoration;
      case 'LABELS':
        return MasterDetailType.labelsDecoration;
      default:
        return null;
    }
  }
}

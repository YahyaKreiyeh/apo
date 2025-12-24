import 'package:apo/features/checkout/data/models/create_transfer_dto.dart';
import 'package:apo/features/checkout/domain/models/create_transfer_parameters.dart';

extension CreateTransferParametersMapper on CreateTransferParameters {
  CreateTransferDto toDto() {
    return CreateTransferDto(
      transferCode: transferCode,
      transferName: transferName,
      description: description,
      thumbnailUrl: thumbnailUrl,
      designFileUrl: designFileUrl,
      artworkUrl: artworkUrl,
      artworkThumbnailUrl: artworkThumbnailUrl,
      transferTypeId: transferTypeId,
      defaultSheetTypeId: defaultSheetTypeId,
    );
  }
}

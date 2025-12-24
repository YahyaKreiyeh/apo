import 'package:apo/features/checkout/data/models/transfer_model.dart';
import 'package:apo/features/checkout/domain/models/transfer_entity.dart';

extension TransferModelMapper on TransferModel? {
  TransferEntity? toEntity() {
    return TransferEntity(
      transferId: this?.transferId ?? 0,
      transferType: this?.transferType ?? '',
      transferTypeId: this?.transferTypeId ?? 0,
      sheetTypeId: this?.sheetTypeId ?? 0,
      transferCatalogId: this?.transferCatalogId ?? 0,
      transferCode: this?.transferCode ?? '',
      transferName: this?.transferName ?? '',
      artworkUrl: this?.artworkUrl ?? '',
      artworkThumbnailUrl: this?.artworkThumbnailUrl ?? '',
      createdAt: this?.createdAt,
      updatedAt: this?.updatedAt,
    );
  }
}

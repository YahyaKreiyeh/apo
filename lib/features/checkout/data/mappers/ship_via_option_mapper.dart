import 'package:apo/features/checkout/data/models/ship_via_option_model.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';

extension ShipViaOptionModelMapper on ShipViaOptionModel? {
  ShipViaOptionEntity? toEntity() {
    return ShipViaOptionEntity(
      id: this?.id ?? 0,
      detailName: this?.detailName ?? '',
      detailCode: this?.detailCode ?? '',
      displayOrder: this?.displayOrder ?? 0,
      isActive: this?.isActive ?? false,
    );
  }
}

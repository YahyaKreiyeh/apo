import 'package:apo/features/home/data/models/master_detail_model.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';

extension MasterDetailModelMapper on MasterDetailModel? {
  MasterDetailEntity? toEntity() {
    return MasterDetailEntity(
      id: this?.id ?? 0,
      detailName: this?.detailName ?? '',
      detailCode: this?.detailCode ?? '',
      displayOrder: this?.displayOrder ?? 0,
      isActive: this?.isActive ?? false,
    );
  }
}

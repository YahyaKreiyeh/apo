import 'package:apo/features/home/data/models/job_model.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';

extension JobModelMapper on JobModel? {
  OrderEntity toEntity() {
    final job = this;
    return OrderEntity(
      jobId: job?.jobId ?? 0,
      jobNumber: job?.jobNumber ?? '',
      jobOwner: job?.jobOwner ?? '',
      poNumber: job?.poNumber,
      status: job?.statusDetailName ?? '',
      requestedShipDate: job?.requestedShipDate,
      createdAt: job?.createdAt,
      totalAmount: job?.totalAmount ?? 0,
      itemsCount: job?.itemsCount ?? 0,
      transfersCount: job?.transfersCount ?? 0,
    );
  }
}

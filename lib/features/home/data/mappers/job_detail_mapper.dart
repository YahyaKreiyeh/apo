import 'package:apo/features/home/data/models/job_detail_model.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';

extension JobDetailModelMapper on JobDetailModel? {
  OrderDetailEntity toEntity() {
    final job = this;
    return OrderDetailEntity(
      jobId: job?.jobId ?? 0,
      jobNumber: job?.jobNumber ?? '',
      jobOwner: job?.jobOwner ?? '',
      companyName: job?.companyName,
      poNumber: job?.poNumber,
      status: job?.statusDetailName ?? '',
      requestedShipDate: job?.requestedShipDate,
      createdAt: job?.createdAt,
      subtotalAmount: job?.subtotalAmount ?? 0,
      discountAmount: job?.discountAmount ?? 0,
      taxAmount: job?.taxAmount ?? 0,
      shippingAmount: job?.shippingAmount ?? 0,
      totalAmount: job?.totalAmount ?? 0,
      customerNotes: job?.customerNotes ?? '',
      shippingInstructions: job?.shippingInstructions ?? '',
      items:
          job?.items.map((item) => item.toEntity()).toList() ?? const [],
      addresses:
          job?.addresses.map((address) => address.toEntity()).toList() ??
          const [],
    );
  }
}

extension JobDetailItemModelMapper on JobDetailItemModel {
  OrderDetailItemEntity toEntity() {
    return OrderDetailItemEntity(
      jobItemId: jobItemId,
      variantId: variantId,
      productName: productName,
      productSku: productSKU,
      variantSku: variantSKU,
      colorName: colorName,
      sizeName: sizeName,
      quantity: quantity,
      unitPrice: unitPrice,
      lineTotal: lineTotal,
      itemStatusName: itemStatusName,
      hasPersonalization: hasPersonalization,
      productionNotes: productionNotes,
      imageUrl: imageUrl,
    );
  }
}

extension JobDetailAddressModelMapper on JobDetailAddressModel {
  OrderDetailAddressEntity toEntity() {
    return OrderDetailAddressEntity(
      addressId: addressId,
      addressType: addressType,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
    );
  }
}

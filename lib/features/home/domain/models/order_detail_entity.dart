class OrderDetailEntity {
  final int jobId;
  final String jobNumber;
  final String jobOwner;
  final String? companyName;
  final String? poNumber;
  final String status;
  final DateTime? requestedShipDate;
  final DateTime? createdAt;
  final num subtotalAmount;
  final num discountAmount;
  final num taxAmount;
  final num shippingAmount;
  final num totalAmount;
  final String customerNotes;
  final String shippingInstructions;
  final List<OrderDetailItemEntity> items;
  final List<OrderDetailAddressEntity> addresses;

  const OrderDetailEntity({
    required this.jobId,
    required this.jobNumber,
    required this.jobOwner,
    required this.companyName,
    required this.poNumber,
    required this.status,
    required this.requestedShipDate,
    required this.createdAt,
    required this.subtotalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.shippingAmount,
    required this.totalAmount,
    required this.customerNotes,
    required this.shippingInstructions,
    required this.items,
    required this.addresses,
  });
}

class OrderDetailItemEntity {
  final int jobItemId;
  final int variantId;
  final String productName;
  final String productSku;
  final String variantSku;
  final String colorName;
  final String? sizeName;
  final int quantity;
  final num unitPrice;
  final num lineTotal;
  final String itemStatusName;
  final bool hasPersonalization;
  final String? productionNotes;
  final String imageUrl;

  const OrderDetailItemEntity({
    required this.jobItemId,
    required this.variantId,
    required this.productName,
    required this.productSku,
    required this.variantSku,
    required this.colorName,
    required this.sizeName,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    required this.itemStatusName,
    required this.hasPersonalization,
    required this.productionNotes,
    required this.imageUrl,
  });
}

class OrderDetailAddressEntity {
  final int addressId;
  final String addressType;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const OrderDetailAddressEntity({
    required this.addressId,
    required this.addressType,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });
}

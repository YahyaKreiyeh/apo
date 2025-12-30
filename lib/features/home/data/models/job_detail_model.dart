import 'package:json_annotation/json_annotation.dart';

part 'job_detail_model.g.dart';

@JsonSerializable()
class JobDetailModel {
  @JsonKey(defaultValue: 0)
  final int jobId;
  @JsonKey(defaultValue: '')
  final String jobNumber;
  @JsonKey(defaultValue: '')
  final String jobOwner;
  final String? companyName;
  final DateTime? requestedShipDate;
  @JsonKey(defaultValue: '')
  final String statusDetailName;
  final String? poNumber;
  @JsonKey(defaultValue: 0)
  final num subtotalAmount;
  @JsonKey(defaultValue: 0)
  final num discountAmount;
  @JsonKey(defaultValue: 0)
  final num taxAmount;
  @JsonKey(defaultValue: 0)
  final num shippingAmount;
  @JsonKey(defaultValue: 0)
  final num totalAmount;
  @JsonKey(defaultValue: '')
  final String customerNotes;
  @JsonKey(defaultValue: '')
  final String shippingInstructions;
  final DateTime? createdAt;
  @JsonKey(defaultValue: <JobDetailItemModel>[])
  final List<JobDetailItemModel> items;
  @JsonKey(defaultValue: <JobDetailAddressModel>[])
  final List<JobDetailAddressModel> addresses;

  const JobDetailModel({
    required this.jobId,
    required this.jobNumber,
    required this.jobOwner,
    required this.companyName,
    required this.requestedShipDate,
    required this.statusDetailName,
    required this.poNumber,
    required this.subtotalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.shippingAmount,
    required this.totalAmount,
    required this.customerNotes,
    required this.shippingInstructions,
    required this.createdAt,
    required this.items,
    required this.addresses,
  });

  factory JobDetailModel.fromJson(Map<String, dynamic> json) =>
      _$JobDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailModelToJson(this);
}

@JsonSerializable()
class JobDetailItemModel {
  @JsonKey(defaultValue: 0)
  final int jobItemId;
  @JsonKey(defaultValue: 0)
  final int variantId;
  @JsonKey(defaultValue: '')
  final String productName;
  @JsonKey(defaultValue: '')
  final String productSKU;
  @JsonKey(defaultValue: '')
  final String variantSKU;
  @JsonKey(defaultValue: '')
  final String colorName;
  final String? sizeName;
  @JsonKey(defaultValue: 0)
  final int quantity;
  @JsonKey(defaultValue: 0)
  final num unitPrice;
  @JsonKey(defaultValue: 0)
  final num lineTotal;
  @JsonKey(defaultValue: '')
  final String itemStatusName;
  @JsonKey(defaultValue: false)
  final bool hasPersonalization;
  final String? productionNotes;
  @JsonKey(defaultValue: '')
  final String imageUrl;

  const JobDetailItemModel({
    required this.jobItemId,
    required this.variantId,
    required this.productName,
    required this.productSKU,
    required this.variantSKU,
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

  factory JobDetailItemModel.fromJson(Map<String, dynamic> json) =>
      _$JobDetailItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailItemModelToJson(this);
}

@JsonSerializable()
class JobDetailAddressModel {
  @JsonKey(defaultValue: 0)
  final int addressId;
  @JsonKey(defaultValue: '')
  final String addressType;
  @JsonKey(defaultValue: '')
  final String addressLine1;
  @JsonKey(defaultValue: '')
  final String addressLine2;
  @JsonKey(defaultValue: '')
  final String city;
  @JsonKey(defaultValue: '')
  final String state;
  @JsonKey(defaultValue: '')
  final String country;
  @JsonKey(defaultValue: '')
  final String zipCode;

  const JobDetailAddressModel({
    required this.addressId,
    required this.addressType,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory JobDetailAddressModel.fromJson(Map<String, dynamic> json) =>
      _$JobDetailAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailAddressModelToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailModel _$JobDetailModelFromJson(Map<String, dynamic> json) =>
    JobDetailModel(
      jobId: (json['jobId'] as num?)?.toInt() ?? 0,
      jobNumber: json['jobNumber'] as String? ?? '',
      jobOwner: json['jobOwner'] as String? ?? '',
      companyName: json['companyName'] as String?,
      requestedShipDate: json['requestedShipDate'] == null
          ? null
          : DateTime.parse(json['requestedShipDate'] as String),
      statusDetailName: json['statusDetailName'] as String? ?? '',
      poNumber: json['poNumber'] as String?,
      subtotalAmount: json['subtotalAmount'] as num? ?? 0,
      discountAmount: json['discountAmount'] as num? ?? 0,
      taxAmount: json['taxAmount'] as num? ?? 0,
      shippingAmount: json['shippingAmount'] as num? ?? 0,
      totalAmount: json['totalAmount'] as num? ?? 0,
      customerNotes: json['customerNotes'] as String? ?? '',
      shippingInstructions: json['shippingInstructions'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => JobDetailItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map(
                (e) =>
                    JobDetailAddressModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$JobDetailModelToJson(JobDetailModel instance) =>
    <String, dynamic>{
      'jobId': instance.jobId,
      'jobNumber': instance.jobNumber,
      'jobOwner': instance.jobOwner,
      'companyName': instance.companyName,
      'requestedShipDate': instance.requestedShipDate?.toIso8601String(),
      'statusDetailName': instance.statusDetailName,
      'poNumber': instance.poNumber,
      'subtotalAmount': instance.subtotalAmount,
      'discountAmount': instance.discountAmount,
      'taxAmount': instance.taxAmount,
      'shippingAmount': instance.shippingAmount,
      'totalAmount': instance.totalAmount,
      'customerNotes': instance.customerNotes,
      'shippingInstructions': instance.shippingInstructions,
      'createdAt': instance.createdAt?.toIso8601String(),
      'items': instance.items,
      'addresses': instance.addresses,
    };

JobDetailItemModel _$JobDetailItemModelFromJson(Map<String, dynamic> json) =>
    JobDetailItemModel(
      jobItemId: (json['jobItemId'] as num?)?.toInt() ?? 0,
      variantId: (json['variantId'] as num?)?.toInt() ?? 0,
      productName: json['productName'] as String? ?? '',
      productSKU: json['productSKU'] as String? ?? '',
      variantSKU: json['variantSKU'] as String? ?? '',
      colorName: json['colorName'] as String? ?? '',
      sizeName: json['sizeName'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: json['unitPrice'] as num? ?? 0,
      lineTotal: json['lineTotal'] as num? ?? 0,
      itemStatusName: json['itemStatusName'] as String? ?? '',
      hasPersonalization: json['hasPersonalization'] as bool? ?? false,
      productionNotes: json['productionNotes'] as String?,
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$JobDetailItemModelToJson(JobDetailItemModel instance) =>
    <String, dynamic>{
      'jobItemId': instance.jobItemId,
      'variantId': instance.variantId,
      'productName': instance.productName,
      'productSKU': instance.productSKU,
      'variantSKU': instance.variantSKU,
      'colorName': instance.colorName,
      'sizeName': instance.sizeName,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'lineTotal': instance.lineTotal,
      'itemStatusName': instance.itemStatusName,
      'hasPersonalization': instance.hasPersonalization,
      'productionNotes': instance.productionNotes,
      'imageUrl': instance.imageUrl,
    };

JobDetailAddressModel _$JobDetailAddressModelFromJson(
  Map<String, dynamic> json,
) => JobDetailAddressModel(
  addressId: (json['addressId'] as num?)?.toInt() ?? 0,
  addressType: json['addressType'] as String? ?? '',
  addressLine1: json['addressLine1'] as String? ?? '',
  addressLine2: json['addressLine2'] as String? ?? '',
  city: json['city'] as String? ?? '',
  state: json['state'] as String? ?? '',
  country: json['country'] as String? ?? '',
  zipCode: json['zipCode'] as String? ?? '',
);

Map<String, dynamic> _$JobDetailAddressModelToJson(
  JobDetailAddressModel instance,
) => <String, dynamic>{
  'addressId': instance.addressId,
  'addressType': instance.addressType,
  'addressLine1': instance.addressLine1,
  'addressLine2': instance.addressLine2,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
};

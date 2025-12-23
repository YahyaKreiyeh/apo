// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_request_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteRequestResponseModel _$QuoteRequestResponseModelFromJson(
  Map<String, dynamic> json,
) => QuoteRequestResponseModel(
  quoteRequestId: (json['quoteRequestId'] as num).toInt(),
  requestNumber: json['requestNumber'] as String,
  userId: json['userId'] as String?,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  companyName: json['companyName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  customerNotes: json['customerNotes'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => QuoteRequestItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  shippingAddress: QuoteRequestAddressModel.fromJson(
    json['shippingAddress'] as Map<String, dynamic>,
  ),
  billingAddress: QuoteRequestAddressModel.fromJson(
    json['billingAddress'] as Map<String, dynamic>,
  ),
  metadata: QuoteRequestMetadataModel.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
  isProcessed: json['isProcessed'] as bool,
  processedAt: json['processedAt'] == null
      ? null
      : DateTime.parse(json['processedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$QuoteRequestResponseModelToJson(
  QuoteRequestResponseModel instance,
) => <String, dynamic>{
  'quoteRequestId': instance.quoteRequestId,
  'requestNumber': instance.requestNumber,
  'userId': instance.userId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'companyName': instance.companyName,
  'email': instance.email,
  'phone': instance.phone,
  'customerNotes': instance.customerNotes,
  'items': instance.items,
  'shippingAddress': instance.shippingAddress,
  'billingAddress': instance.billingAddress,
  'metadata': instance.metadata,
  'isProcessed': instance.isProcessed,
  'processedAt': instance.processedAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

QuoteRequestItemModel _$QuoteRequestItemModelFromJson(
  Map<String, dynamic> json,
) => QuoteRequestItemModel(
  variantId: (json['variantId'] as num).toInt(),
  quantity: (json['quantity'] as num).toInt(),
  hasPersonalization: json['hasPersonalization'] as bool,
  productionNotes: json['productionNotes'] as String,
  product: ProductDetailsModel.fromJson(
    json['product'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$QuoteRequestItemModelToJson(
  QuoteRequestItemModel instance,
) => <String, dynamic>{
  'variantId': instance.variantId,
  'quantity': instance.quantity,
  'hasPersonalization': instance.hasPersonalization,
  'productionNotes': instance.productionNotes,
  'product': instance.product,
};

QuoteRequestAddressModel _$QuoteRequestAddressModelFromJson(
  Map<String, dynamic> json,
) => QuoteRequestAddressModel(
  orderAddressId: (json['orderAddressId'] as num?)?.toInt(),
  addressType: json['addressType'] as String?,
  addressLine1: json['addressLine1'] as String,
  addressLine2: json['addressLine2'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  country: json['country'] as String,
  zipCode: json['zipCode'] as String,
);

Map<String, dynamic> _$QuoteRequestAddressModelToJson(
  QuoteRequestAddressModel instance,
) => <String, dynamic>{
  'orderAddressId': instance.orderAddressId,
  'addressType': instance.addressType,
  'addressLine1': instance.addressLine1,
  'addressLine2': instance.addressLine2,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
};

QuoteRequestMetadataModel _$QuoteRequestMetadataModelFromJson(
  Map<String, dynamic> json,
) => QuoteRequestMetadataModel(
  jobNumber: json['jobNumber'] as String?,
  orderCodeValue: json['orderCodeValue'] as String?,
  customerCode: json['customerCode'] as String?,
  companyName: json['companyName'] as String?,
  productInHouse: json['productInHouse'] as String?,
  productConstruct: json['productConstruct'] as String?,
  poNumber: json['poNumber'] as String?,
  artworkDescription: json['artworkDescription'] as String,
  numLocations: (json['numLocations'] as num).toInt(),
  shipDate: json['shipDate'] == null
      ? null
      : DateTime.parse(json['shipDate'] as String),
  internalNotes: json['internalNotes'] as String?,
);

Map<String, dynamic> _$QuoteRequestMetadataModelToJson(
  QuoteRequestMetadataModel instance,
) => <String, dynamic>{
  'jobNumber': instance.jobNumber,
  'orderCodeValue': instance.orderCodeValue,
  'customerCode': instance.customerCode,
  'companyName': instance.companyName,
  'productInHouse': instance.productInHouse,
  'productConstruct': instance.productConstruct,
  'poNumber': instance.poNumber,
  'artworkDescription': instance.artworkDescription,
  'numLocations': instance.numLocations,
  'shipDate': instance.shipDate?.toIso8601String(),
  'internalNotes': instance.internalNotes,
};

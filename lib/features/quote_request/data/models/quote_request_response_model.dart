import 'package:apo/features/home/data/models/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_request_response_model.g.dart';

@JsonSerializable()
class QuoteRequestResponseModel {
  final int quoteRequestId;
  final String requestNumber;
  final String? userId;
  final String firstName;
  final String lastName;
  final String companyName;
  final String email;
  final String phone;
  final String customerNotes;
  final List<QuoteRequestItemModel> items;
  final QuoteRequestAddressModel shippingAddress;
  final QuoteRequestAddressModel billingAddress;
  final QuoteRequestMetadataModel metadata;
  final bool isProcessed;
  final DateTime? processedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuoteRequestResponseModel({
    required this.quoteRequestId,
    required this.requestNumber,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.customerNotes,
    required this.items,
    required this.shippingAddress,
    required this.billingAddress,
    required this.metadata,
    required this.isProcessed,
    required this.processedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuoteRequestResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteRequestResponseModelToJson(this);
}

@JsonSerializable()
class QuoteRequestItemModel {
  final int variantId;
  final int quantity;
  final bool hasPersonalization;
  final String productionNotes;
  final ProductDetailsModel product;

  const QuoteRequestItemModel({
    required this.variantId,
    required this.quantity,
    required this.hasPersonalization,
    required this.productionNotes,
    required this.product,
  });

  factory QuoteRequestItemModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteRequestItemModelToJson(this);
}

@JsonSerializable()
class QuoteRequestAddressModel {
  final int? orderAddressId;
  final String? addressType;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const QuoteRequestAddressModel({
    required this.orderAddressId,
    required this.addressType,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory QuoteRequestAddressModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteRequestAddressModelToJson(this);
}

@JsonSerializable()
class QuoteRequestMetadataModel {
  final String? jobNumber;
  final String? orderCodeValue;
  final String? customerCode;
  final String? companyName;
  final String? productInHouse;
  final String? productConstruct;
  final String? poNumber;
  final String artworkDescription;
  final int numLocations;
  final DateTime? shipDate;
  final String? internalNotes;

  const QuoteRequestMetadataModel({
    required this.jobNumber,
    required this.orderCodeValue,
    required this.customerCode,
    required this.companyName,
    required this.productInHouse,
    required this.productConstruct,
    required this.poNumber,
    required this.artworkDescription,
    required this.numLocations,
    required this.shipDate,
    required this.internalNotes,
  });

  factory QuoteRequestMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteRequestMetadataModelToJson(this);
}

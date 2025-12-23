import 'package:apo/features/home/data/models/product_details_model.dart';

class QuoteRequestDto {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String companyName;
  final List<QuoteRequestItemDto> items;
  final QuoteRequestAddressDto shippingAddress;
  final QuoteRequestAddressDto billingAddress;
  final String customerNotes;
  final QuoteRequestMetadataDto metadata;

  const QuoteRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.companyName,
    required this.items,
    required this.shippingAddress,
    required this.billingAddress,
    required this.customerNotes,
    required this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'companyName': companyName,
        'items': items.map((item) => item.toJson()).toList(),
        'shippingAddress': shippingAddress.toJson(),
        'billingAddress': billingAddress.toJson(),
        'customerNotes': customerNotes,
        'metadata': metadata.toJson(),
      };
}

class QuoteRequestItemDto {
  final int variantId;
  final int quantity;
  final bool hasPersonalization;
  final String productionNotes;
  final ProductDetailsModel product;

  const QuoteRequestItemDto({
    required this.variantId,
    required this.quantity,
    required this.hasPersonalization,
    required this.productionNotes,
    required this.product,
  });

  Map<String, dynamic> toJson() => {
        'variantId': variantId,
        'quantity': quantity,
        'hasPersonalization': hasPersonalization,
        'productionNotes': productionNotes,
        'product': product.toJson(),
      };
}

class QuoteRequestAddressDto {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const QuoteRequestAddressDto({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() => {
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'state': state,
        'country': country,
        'zipCode': zipCode,
      };
}

class QuoteRequestMetadataDto {
  final String artworkDescription;
  final int numLocations;
  final String shipDate;

  const QuoteRequestMetadataDto({
    required this.artworkDescription,
    required this.numLocations,
    required this.shipDate,
  });

  Map<String, dynamic> toJson() => {
        'artworkDescription': artworkDescription,
        'numLocations': numLocations,
        'shipDate': shipDate,
      };
}

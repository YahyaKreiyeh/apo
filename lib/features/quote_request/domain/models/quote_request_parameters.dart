import 'package:apo/features/home/domain/models/cart_item_entity.dart';

class QuoteRequestParameters {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String companyName;
  final List<CartItemEntity> items;
  final QuoteRequestAddressParameters shippingAddress;
  final QuoteRequestAddressParameters billingAddress;
  final String customerNotes;
  final QuoteRequestMetadataParameters metadata;

  const QuoteRequestParameters({
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
}

class QuoteRequestAddressParameters {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const QuoteRequestAddressParameters({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });
}

class QuoteRequestMetadataParameters {
  final String artworkDescription;
  final int numLocations;
  final DateTime shipDate;

  const QuoteRequestMetadataParameters({
    required this.artworkDescription,
    required this.numLocations,
    required this.shipDate,
  });
}

import 'package:apo/features/checkout/data/models/quote_request_dto.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';

extension QuoteRequestParametersMapper on QuoteRequestParameters? {
  QuoteRequestDto toDto() {
    return QuoteRequestDto(
      firstName: this?.firstName ?? '',
      lastName: this?.lastName ?? '',
      email: this?.email ?? '',
      phone: this?.phone ?? '',
      companyName: this?.companyName ?? '',
      items:
          this?.items.map((item) => item.toQuoteItemDto()).toList() ?? const [],
      shippingAddress: QuoteRequestAddressDto(
        addressLine1: this?.shippingAddress.addressLine1 ?? '',
        addressLine2: this?.shippingAddress.addressLine2 ?? '',
        city: this?.shippingAddress.city ?? '',
        state: this?.shippingAddress.state ?? '',
        country: this?.shippingAddress.country ?? 'USA',
        zipCode: this?.shippingAddress.zipCode ?? '',
      ),
      billingAddress: QuoteRequestAddressDto(
        addressLine1: this?.billingAddress.addressLine1 ?? '',
        addressLine2: this?.billingAddress.addressLine2 ?? '',
        city: this?.billingAddress.city ?? '',
        state: this?.billingAddress.state ?? '',
        country: this?.billingAddress.country ?? 'USA',
        zipCode: this?.billingAddress.zipCode ?? '',
      ),
      customerNotes: this?.customerNotes ?? '',
      metadata: QuoteRequestMetadataDto(
        artworkDescription: this?.metadata.artworkDescription ?? '',
        numLocations: this?.metadata.numLocations ?? 0,
      ),
    );
  }
}

extension _CartItemEntityMapper on CartItemEntity? {
  QuoteRequestItemDto toQuoteItemDto() {
    return QuoteRequestItemDto(
      variantId: this?.variantId ?? 0,
      quantity: this?.quantity ?? 0,
      hasPersonalization: this?.hasPersonalization ?? false,
      productionNotes: '',
    );
  }
}

import 'package:apo/features/home/data/models/product_details_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/quote_request/data/models/quote_request_dto.dart';
import 'package:apo/features/quote_request/domain/models/quote_request_parameters.dart';

extension QuoteRequestParametersMapper on QuoteRequestParameters? {
  QuoteRequestDto toDto() {
    final now = DateTime.now().toUtc();
    return QuoteRequestDto(
      firstName: this?.firstName ?? '',
      lastName: this?.lastName ?? '',
      email: this?.email ?? '',
      phone: this?.phone ?? '',
      companyName: this?.companyName ?? '',
      items:
          this?.items.map((item) => item.toQuoteItemDto(now)).toList() ??
          const [],
      shippingAddress: QuoteRequestAddressDto(
        addressLine1: this?.shippingAddress.addressLine1 ?? '',
        addressLine2: this?.shippingAddress.addressLine2 ?? '',
        city: this?.shippingAddress.city ?? '',
        state: this?.shippingAddress.state ?? '',
        country: this?.shippingAddress.country ?? '',
        zipCode: this?.shippingAddress.zipCode ?? '',
      ),
      billingAddress: QuoteRequestAddressDto(
        addressLine1: this?.billingAddress.addressLine1 ?? '',
        addressLine2: this?.billingAddress.addressLine2 ?? '',
        city: this?.billingAddress.city ?? '',
        state: this?.billingAddress.state ?? '',
        country: this?.billingAddress.country ?? '',
        zipCode: this?.billingAddress.zipCode ?? '',
      ),
      customerNotes: this?.customerNotes ?? '',
      metadata: QuoteRequestMetadataDto(
        artworkDescription: this?.metadata.artworkDescription ?? '',
        numLocations: this?.metadata.numLocations ?? 0,
        shipDate: (this?.metadata.shipDate ?? now).toUtc().toIso8601String(),
      ),
    );
  }
}

extension _CartItemEntityMapper on CartItemEntity? {
  QuoteRequestItemDto toQuoteItemDto(DateTime now) {
    return QuoteRequestItemDto(
      variantId: this?.variantId ?? 0,
      quantity: this?.quantity ?? 0,
      hasPersonalization: this?.hasPersonalization ?? false,
      productionNotes: '',
      product: ProductDetailsModel(
        productId: this?.productId ?? 0,
        productSKU: this?.productSku ?? '',
        productName: this?.name ?? '',
        description: this?.name ?? '',
        model3DUrl: '',
        model3DThumbnail: '',
        hasVariants: false,
        hasCustomization: false,
        isStockItem: false,
        isUSAMade: false,
        manufacturingLocation: '',
        minimumOrderQuantity: 0,
        standardProductionDays: 0,
        rushProductionDays: 0,
        isActive: true,
        categories: const [],
        variants: const [],
        images: const [],
        placementAreas: const [],
        decorationMethods: const [],
        createdAt: now,
        updatedAt: now,
      ),
    );
  }
}

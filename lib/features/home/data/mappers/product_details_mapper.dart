import 'package:apo/features/home/data/mappers/product_mapper.dart';
import 'package:apo/features/home/data/models/product_details_model.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';

extension ProductDetailsModelMapper on ProductDetailsModel? {
  ProductDetailsEntity toDomain() {
    return ProductDetailsEntity(
      productId: this?.productId ?? 0,
      productSKU: this?.productSKU ?? '',
      productName: this?.productName ?? '',
      description: this?.description ?? '',
      model3DUrl: this?.model3DUrl ?? '',
      model3DThumbnail: this?.model3DThumbnail ?? '',
      hasVariants: this?.hasVariants ?? false,
      hasCustomization: this?.hasCustomization ?? false,
      isStockItem: this?.isStockItem ?? false,
      isUSAMade: this?.isUSAMade ?? false,
      manufacturingLocation: this?.manufacturingLocation ?? '',
      minimumOrderQuantity: this?.minimumOrderQuantity ?? 0,
      standardProductionDays: this?.standardProductionDays ?? 0,
      rushProductionDays: this?.rushProductionDays ?? 0,
      isActive: this?.isActive ?? false,
      categories:
          this?.categories.map((category) => category.toDomain()).toList() ??
              const [],
      variants:
          this?.variants.map((variant) => variant.toDomain()).toList() ??
              const [],
      images: this?.images.map((image) => image.toDomain()).toList() ?? const [],
      placementAreas: this?.placementAreas ?? const [],
      decorationMethods: this?.decorationMethods ?? const [],
      createdAt: this?.createdAt,
      updatedAt: this?.updatedAt,
    );
  }
}

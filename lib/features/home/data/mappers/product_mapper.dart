import 'package:apo/features/home/data/models/product_model.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';

extension ProductModelMapper on ProductModel? {
  ProductEntity toDomain() {
    final categories = this?.categories ?? const <CategoryModel>[];
    return ProductEntity(
      productId: this?.productId ?? 0,
      productSKU: this?.productSKU ?? '',
      productName: this?.productName ?? '',
      description: this?.description ?? '',
      hasVariants: this?.hasVariants ?? false,
      hasCustomization: this?.hasCustomization ?? false,
      minimumOrderQuantity: this?.minimumOrderQuantity ?? 0,
      standardProductionDays: this?.standardProductionDays ?? 0,
      basePrice: this?.basePrice ?? 0,
      isActive: this?.isActive ?? false,
      categories: categories.isEmpty
          ? const []
          : categories.map((category) => category.toDomain()).toList(),
      mainImage: this?.mainImage?.toDomain(),
      variantCount: this?.variantCount ?? 0,
      priceRange: this?.priceRange?.toDomain(),
      availableColors: this?.availableColors ?? const [],
      availableSizes: this?.availableSizes ?? const [],
      variants:
          this?.variants.map((variant) => variant.toDomain()).toList() ??
          const [],
      createdAt: this?.createdAt,
      updatedAt: this?.updatedAt,
    );
  }
}

extension CategoryModelMapper on CategoryModel {
  CategoryEntity toDomain() {
    return CategoryEntity(categoryId: categoryId, categoryName: categoryName);
  }
}

extension ProductImageModelMapper on ProductImageModel {
  ProductImageEntity toDomain() {
    return ProductImageEntity(
      imageId: imageId,
      imageUrl: imageUrl,
      thumbnailUrl: thumbnailUrl,
      imageType: imageType,
      displayOrder: displayOrder,
      altText: altText,
    );
  }
}

extension PriceRangeModelMapper on PriceRangeModel {
  PriceRangeEntity toDomain() {
    return PriceRangeEntity(min: min, max: max);
  }
}

extension VariantModelMapper on VariantModel {
  VariantEntity toDomain() {
    return VariantEntity(
      variantId: variantId,
      variantSKU: variantSKU,
      colorName: colorName,
      colorCode: colorCode,
      sizeType: sizeType?.toDomain(),
      basePrice: basePrice,
      weight: weight,
      dimensions: dimensions,
      isActive: isActive,
      inventoryAvailable: inventoryAvailable,
      images: images.map((image) => image.toDomain()).toList(),
    );
  }
}

extension SizeTypeModelMapper on SizeTypeModel {
  SizeTypeEntity toDomain() {
    return SizeTypeEntity(
      sizeTypeId: sizeTypeId,
      sizeCode: sizeCode,
      sizeName: sizeName,
    );
  }
}

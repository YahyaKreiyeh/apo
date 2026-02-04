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
      minimumOrderQuantity: this?.minimumOrderQuantity ?? 0,
      basePrice: this?.basePrice ?? 0,
      isActive: this?.isActive ?? false,
      isStockItem: this?.isStockItem ?? false,
      isUSAMade: this?.isUSAMade ?? false,
      categories: categories.isEmpty
          ? const []
          : categories.map((category) => category.toDomain()).toList(),
      images:
          this?.images.map((image) => image.toDomain()).toList() ?? const [],
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

extension CategoryModelMapper on CategoryModel? {
  CategoryEntity toDomain() {
    return CategoryEntity(
      categoryId: this?.categoryId,
      categoryName: this?.categoryName,
      categorySlug: this?.categorySlug,
      imageUrl: this?.imageUrl,
      parentCategoryId: this?.parentCategoryId,
      description: this?.description,
      displayOrder: this?.displayOrder,
      isActive: this?.isActive,
    );
  }
}

extension ProductImageModelMapper on ProductImageModel? {
  ProductImageEntity toDomain() {
    return ProductImageEntity(
      imageId: this?.imageId ?? 0,
      imageUrl: this?.imageUrl ?? '',
      originalImageUrl: this?.originalImageUrl ?? '',
      imageType: this?.imageType?.toDomain(),
      displayOrder: this?.displayOrder ?? 0,
      altText: this?.altText ?? '',
    );
  }
}

extension ImageTypeModelMapper on ImageTypeModel? {
  ImageTypeEntity toDomain() {
    return ImageTypeEntity(
      masterDetailId: this?.masterDetailId ?? 0,
      masterId: this?.masterId ?? 0,
      detailName: this?.detailName ?? '',
      detailCode: this?.detailCode ?? '',
      description: this?.description,
      displayOrder: this?.displayOrder ?? 0,
      isActive: this?.isActive ?? false,
      createdAt: this?.createdAt,
      updatedAt: this?.updatedAt,
    );
  }
}

extension PriceRangeModelMapper on PriceRangeModel? {
  PriceRangeEntity toDomain() {
    return PriceRangeEntity(min: this?.min ?? 0, max: this?.max ?? 0);
  }
}

extension VariantModelMapper on VariantModel? {
  VariantEntity toDomain() {
    return VariantEntity(
      variantId: this?.variantId ?? 0,
      variantSKU: this?.variantSKU ?? '',
      colorName: this?.colorName ?? '',
      colorCode: this?.colorCode ?? '',
      sizeType: this?.sizeType?.toDomain(),
      basePrice: this?.basePrice ?? 0,
      weight: this?.weight ?? 0,
      dimensions: this?.dimensions ?? '',
      isActive: this?.isActive ?? false,
      inventoryAvailable: this?.inventoryAvailable ?? 0,
      images:
          this?.images.map((image) => image.toDomain()).toList() ?? const [],
    );
  }
}

extension SizeTypeModelMapper on SizeTypeModel? {
  SizeTypeEntity toDomain() {
    return SizeTypeEntity(
      sizeTypeId: this?.sizeTypeId ?? 0,
      sizeCode: this?.sizeCode ?? '',
      sizeName: this?.sizeName ?? '',
    );
  }
}

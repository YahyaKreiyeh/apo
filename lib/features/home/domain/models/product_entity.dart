class ProductEntity {
  final int productId;
  final String productSKU;
  final String productName;
  final String description;
  final int minimumOrderQuantity;
  final double basePrice;
  final bool isActive;
  final bool isStockItem;
  final bool isUSAMade;
  final List<CategoryEntity> categories;
  final List<ProductImageEntity> images;
  final int variantCount;
  final PriceRangeEntity? priceRange;
  final List<String> availableColors;
  final List<String> availableSizes;
  final List<VariantEntity> variants;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductEntity({
    required this.productId,
    required this.productSKU,
    required this.productName,
    required this.description,
    required this.minimumOrderQuantity,
    required this.basePrice,
    required this.isActive,
    required this.isStockItem,
    required this.isUSAMade,
    required this.categories,
    required this.images,
    required this.variantCount,
    required this.priceRange,
    required this.availableColors,
    required this.availableSizes,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
  });
}

class CategoryEntity {
  final int? categoryId;
  final String? categoryName;
  final String? categorySlug;
  final String? imageUrl;
  final int? parentCategoryId;
  final String? description;
  final int? displayOrder;
  final bool? isActive;

  const CategoryEntity({
    this.categoryId,
    this.categoryName,
    this.categorySlug,
    this.imageUrl,
    this.parentCategoryId,
    this.description,
    this.displayOrder,
    this.isActive,
  });
}

class ProductImageEntity {
  final int imageId;
  final String imageUrl;
  final String originalImageUrl;
  final ImageTypeEntity? imageType;
  final int displayOrder;
  final String altText;

  const ProductImageEntity({
    required this.imageId,
    required this.imageUrl,
    required this.originalImageUrl,
    required this.imageType,
    required this.displayOrder,
    required this.altText,
  });
}

class ImageTypeEntity {
  final int masterDetailId;
  final int masterId;
  final String detailName;
  final String detailCode;
  final String? description;
  final int displayOrder;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ImageTypeEntity({
    required this.masterDetailId,
    required this.masterId,
    required this.detailName,
    required this.detailCode,
    required this.description,
    required this.displayOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
}

class PriceRangeEntity {
  final double min;
  final double max;

  const PriceRangeEntity({
    required this.min,
    required this.max,
  });
}

class VariantEntity {
  final int variantId;
  final String variantSKU;
  final String colorName;
  final String colorCode;
  final SizeTypeEntity? sizeType;
  final double basePrice;
  final double weight;
  final String dimensions;
  final bool isActive;
  final int inventoryAvailable;
  final List<ProductImageEntity> images;

  const VariantEntity({
    required this.variantId,
    required this.variantSKU,
    required this.colorName,
    required this.colorCode,
    required this.sizeType,
    required this.basePrice,
    required this.weight,
    required this.dimensions,
    required this.isActive,
    required this.inventoryAvailable,
    required this.images,
  });
}

class SizeTypeEntity {
  final int sizeTypeId;
  final String sizeCode;
  final String sizeName;

  const SizeTypeEntity({
    required this.sizeTypeId,
    required this.sizeCode,
    required this.sizeName,
  });
}

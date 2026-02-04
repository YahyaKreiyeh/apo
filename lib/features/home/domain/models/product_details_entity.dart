import 'package:apo/features/home/domain/models/product_entity.dart';

class ProductDetailsEntity {
  final int productId;
  final String productSKU;
  final String productName;
  final String description;
  final String model3DUrl;
  final String model3DThumbnail;
  final bool hasVariants;
  final bool hasCustomization;
  final bool isStockItem;
  final bool isUSAMade;
  final String manufacturingLocation;
  final int minimumOrderQuantity;
  final int standardProductionDays;
  final int rushProductionDays;
  final double basePrice;
  final bool isActive;
  final List<CategoryEntity> categories;
  final List<VariantEntity> variants;
  final List<ProductImageEntity> images;
  final List<dynamic> decorationMethods;
  final List<PricingTierEntity> pricingTiers;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductDetailsEntity({
    required this.productId,
    required this.productSKU,
    required this.productName,
    required this.description,
    required this.model3DUrl,
    required this.model3DThumbnail,
    required this.hasVariants,
    required this.hasCustomization,
    required this.isStockItem,
    required this.isUSAMade,
    required this.manufacturingLocation,
    required this.minimumOrderQuantity,
    required this.standardProductionDays,
    required this.rushProductionDays,
    required this.basePrice,
    required this.isActive,
    required this.categories,
    required this.variants,
    required this.images,
    required this.decorationMethods,
    required this.pricingTiers,
    required this.createdAt,
    required this.updatedAt,
  });
}

class PricingTierEntity {
  final int pricingTierId;
  final String tierName;
  final String tierCode;
  final int minQuantity;
  final int? maxQuantity;
  final int displayOrder;
  final Map<String, double> customizationPrices;

  const PricingTierEntity({
    required this.pricingTierId,
    required this.tierName,
    required this.tierCode,
    required this.minQuantity,
    required this.maxQuantity,
    required this.displayOrder,
    required this.customizationPrices,
  });
}

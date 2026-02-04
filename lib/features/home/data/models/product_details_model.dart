import 'package:apo/features/home/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  final int productId;
  final String productSKU;
  final String productName;
  final String description;
  @JsonKey(defaultValue: '')
  final String model3DUrl;
  @JsonKey(defaultValue: '')
  final String model3DThumbnail;
  @JsonKey(defaultValue: false)
  final bool hasVariants;
  @JsonKey(defaultValue: false)
  final bool hasCustomization;
  final bool isStockItem;
  final bool isUSAMade;
  @JsonKey(defaultValue: '')
  final String manufacturingLocation;
  final int minimumOrderQuantity;
  @JsonKey(defaultValue: 0)
  final int standardProductionDays;
  @JsonKey(defaultValue: 0)
  final int rushProductionDays;
  final double basePrice;
  final bool isActive;
  @JsonKey(defaultValue: <CategoryModel>[])
  final List<CategoryModel> categories;
  @JsonKey(defaultValue: <VariantModel>[])
  final List<VariantModel> variants;
  @JsonKey(defaultValue: <ProductImageModel>[])
  final List<ProductImageModel> images;
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> decorationMethods;
  @JsonKey(defaultValue: <PricingTierModel>[])
  final List<PricingTierModel> pricingTiers;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductDetailsModel({
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

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable()
class PricingTierModel {
  final int pricingTierId;
  final String tierName;
  final String tierCode;
  final int minQuantity;
  final int? maxQuantity;
  final int displayOrder;
  @JsonKey(defaultValue: <String, double>{})
  final Map<String, double> customizationPrices;

  const PricingTierModel({
    required this.pricingTierId,
    required this.tierName,
    required this.tierCode,
    required this.minQuantity,
    required this.maxQuantity,
    required this.displayOrder,
    required this.customizationPrices,
  });

  factory PricingTierModel.fromJson(Map<String, dynamic> json) =>
      _$PricingTierModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricingTierModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int productId;
  final String productSKU;
  final String productName;
  final String description;
  final bool hasVariants;
  final bool hasCustomization;
  final int minimumOrderQuantity;
  final int standardProductionDays;
  final bool isActive;
  final List<CategoryModel> categories;
  final ProductImageModel? mainImage;
  final int variantCount;
  final PriceRangeModel? priceRange;
  final List<String> availableColors;
  final List<String> availableSizes;
  final List<VariantModel> variants;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.productId,
    required this.productSKU,
    required this.productName,
    required this.description,
    required this.hasVariants,
    required this.hasCustomization,
    required this.minimumOrderQuantity,
    required this.standardProductionDays,
    required this.isActive,
    required this.categories,
    required this.mainImage,
    required this.variantCount,
    required this.priceRange,
    required this.availableColors,
    required this.availableSizes,
    required this.variants,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  final int? categoryId;
  final String? categoryName;

  const CategoryModel({this.categoryId, this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class ProductImageModel {
  final int imageId;
  final String imageUrl;
  final String thumbnailUrl;
  final String imageType;
  final int displayOrder;
  final String altText;

  const ProductImageModel({
    required this.imageId,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.imageType,
    required this.displayOrder,
    required this.altText,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageModelToJson(this);
}

@JsonSerializable()
class PriceRangeModel {
  final double min;
  final double max;

  const PriceRangeModel({required this.min, required this.max});

  factory PriceRangeModel.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeModelToJson(this);
}

@JsonSerializable()
class VariantModel {
  final int variantId;
  final String variantSKU;
  final String colorName;
  final String colorCode;
  final SizeTypeModel? sizeType;
  final double basePrice;
  final double weight;
  final String dimensions;
  final bool isActive;
  final int inventoryAvailable;
  final List<ProductImageModel> images;

  const VariantModel({
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

  factory VariantModel.fromJson(Map<String, dynamic> json) =>
      _$VariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantModelToJson(this);
}

@JsonSerializable()
class SizeTypeModel {
  final int sizeTypeId;
  final String sizeCode;
  final String sizeName;

  const SizeTypeModel({
    required this.sizeTypeId,
    required this.sizeCode,
    required this.sizeName,
  });

  factory SizeTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeTypeModelToJson(this);
}

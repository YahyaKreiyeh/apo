import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int productId;
  final String productSKU;
  final String productName;
  final String description;
  final int minimumOrderQuantity;
  final double basePrice;
  final bool isActive;
  final bool isStockItem;
  final bool isUSAMade;
  final List<CategoryModel> categories;
  @JsonKey(defaultValue: <ProductImageModel>[])
  final List<ProductImageModel> images;
  final int variantCount;
  final PriceRangeModel? priceRange;
  @JsonKey(defaultValue: <String>[])
  final List<String> availableColors;
  @JsonKey(defaultValue: <String>[])
  final List<String> availableSizes;
  @JsonKey(defaultValue: <VariantModel>[])
  final List<VariantModel> variants;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class CategoryModel {
  final int? categoryId;
  final String? categoryName;
  final String? categorySlug;
  final String? imageUrl;
  final int? parentCategoryId;
  final String? description;
  final int? displayOrder;
  final bool? isActive;

  const CategoryModel({
    this.categoryId,
    this.categoryName,
    this.categorySlug,
    this.imageUrl,
    this.parentCategoryId,
    this.description,
    this.displayOrder,
    this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class ProductImageModel {
  final int imageId;
  @JsonKey(defaultValue: '')
  final String imageUrl;
  @JsonKey(defaultValue: '')
  final String originalImageUrl;
  final ImageTypeModel? imageType;
  final int displayOrder;
  @JsonKey(defaultValue: '')
  final String altText;

  const ProductImageModel({
    required this.imageId,
    required this.imageUrl,
    required this.originalImageUrl,
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
  @JsonKey(defaultValue: '')
  final String variantSKU;
  @JsonKey(defaultValue: '')
  final String colorName;
  @JsonKey(defaultValue: '')
  final String colorCode;
  final SizeTypeModel? sizeType;
  @JsonKey(defaultValue: 0)
  final double basePrice;
  @JsonKey(defaultValue: 0)
  final double weight;
  @JsonKey(defaultValue: '')
  final String dimensions;
  final bool isActive;
  final int inventoryAvailable;
  @JsonKey(defaultValue: <ProductImageModel>[])
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
  @JsonKey(defaultValue: '')
  final String sizeCode;
  @JsonKey(defaultValue: '')
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

@JsonSerializable()
class ImageTypeModel {
  final int masterDetailId;
  final int masterId;
  @JsonKey(defaultValue: '')
  final String detailName;
  @JsonKey(defaultValue: '')
  final String detailCode;
  final String? description;
  final int displayOrder;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ImageTypeModel({
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

  factory ImageTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ImageTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageTypeModelToJson(this);
}

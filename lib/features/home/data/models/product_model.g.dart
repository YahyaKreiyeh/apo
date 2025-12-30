// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  productId: (json['productId'] as num).toInt(),
  productSKU: json['productSKU'] as String,
  productName: json['productName'] as String,
  description: json['description'] as String,
  hasVariants: json['hasVariants'] as bool,
  hasCustomization: json['hasCustomization'] as bool,
  minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
  standardProductionDays: (json['standardProductionDays'] as num).toInt(),
  basePrice: (json['basePrice'] as num).toDouble(),
  isActive: json['isActive'] as bool,
  categories: (json['categories'] as List<dynamic>)
      .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  mainImage: json['mainImage'] == null
      ? null
      : ProductImageModel.fromJson(json['mainImage'] as Map<String, dynamic>),
  variantCount: (json['variantCount'] as num).toInt(),
  priceRange: json['priceRange'] == null
      ? null
      : PriceRangeModel.fromJson(json['priceRange'] as Map<String, dynamic>),
  availableColors: (json['availableColors'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  availableSizes: (json['availableSizes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  variants: (json['variants'] as List<dynamic>)
      .map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productSKU': instance.productSKU,
      'productName': instance.productName,
      'description': instance.description,
      'hasVariants': instance.hasVariants,
      'hasCustomization': instance.hasCustomization,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      'standardProductionDays': instance.standardProductionDays,
      'basePrice': instance.basePrice,
      'isActive': instance.isActive,
      'categories': instance.categories,
      'mainImage': instance.mainImage,
      'variantCount': instance.variantCount,
      'priceRange': instance.priceRange,
      'availableColors': instance.availableColors,
      'availableSizes': instance.availableSizes,
      'variants': instance.variants,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };

ProductImageModel _$ProductImageModelFromJson(Map<String, dynamic> json) =>
    ProductImageModel(
      imageId: (json['imageId'] as num).toInt(),
      imageUrl: json['imageUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      imageType: json['imageType'] as String? ?? '',
      displayOrder: (json['displayOrder'] as num).toInt(),
      altText: json['altText'] as String? ?? '',
    );

Map<String, dynamic> _$ProductImageModelToJson(ProductImageModel instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'imageType': instance.imageType,
      'displayOrder': instance.displayOrder,
      'altText': instance.altText,
    };

PriceRangeModel _$PriceRangeModelFromJson(Map<String, dynamic> json) =>
    PriceRangeModel(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceRangeModelToJson(PriceRangeModel instance) =>
    <String, dynamic>{'min': instance.min, 'max': instance.max};

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) => VariantModel(
  variantId: (json['variantId'] as num).toInt(),
  variantSKU: json['variantSKU'] as String? ?? '',
  colorName: json['colorName'] as String? ?? '',
  colorCode: json['colorCode'] as String? ?? '',
  sizeType: json['sizeType'] == null
      ? null
      : SizeTypeModel.fromJson(json['sizeType'] as Map<String, dynamic>),
  basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0,
  weight: (json['weight'] as num).toDouble(),
  dimensions: json['dimensions'] as String? ?? '',
  isActive: json['isActive'] as bool,
  inventoryAvailable: (json['inventoryAvailable'] as num).toInt(),
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      'variantId': instance.variantId,
      'variantSKU': instance.variantSKU,
      'colorName': instance.colorName,
      'colorCode': instance.colorCode,
      'sizeType': instance.sizeType,
      'basePrice': instance.basePrice,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'isActive': instance.isActive,
      'inventoryAvailable': instance.inventoryAvailable,
      'images': instance.images,
    };

SizeTypeModel _$SizeTypeModelFromJson(Map<String, dynamic> json) =>
    SizeTypeModel(
      sizeTypeId: (json['sizeTypeId'] as num).toInt(),
      sizeCode: json['sizeCode'] as String? ?? '',
      sizeName: json['sizeName'] as String? ?? '',
    );

Map<String, dynamic> _$SizeTypeModelToJson(SizeTypeModel instance) =>
    <String, dynamic>{
      'sizeTypeId': instance.sizeTypeId,
      'sizeCode': instance.sizeCode,
      'sizeName': instance.sizeName,
    };

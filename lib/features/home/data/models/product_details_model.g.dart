// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      productId: (json['productId'] as num).toInt(),
      productSKU: json['productSKU'] as String,
      productName: json['productName'] as String,
      description: json['description'] as String,
      model3DUrl: json['model3DUrl'] as String,
      model3DThumbnail: json['model3DThumbnail'] as String,
      hasVariants: json['hasVariants'] as bool,
      hasCustomization: json['hasCustomization'] as bool,
      isStockItem: json['isStockItem'] as bool,
      isUSAMade: json['isUSAMade'] as bool,
      manufacturingLocation: json['manufacturingLocation'] as String,
      minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
      standardProductionDays: (json['standardProductionDays'] as num).toInt(),
      rushProductionDays: (json['rushProductionDays'] as num).toInt(),
      isActive: json['isActive'] as bool,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ProductImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      placementAreas: json['placementAreas'] as List<dynamic>,
      decorationMethods: json['decorationMethods'] as List<dynamic>,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
  ProductDetailsModel instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'productSKU': instance.productSKU,
  'productName': instance.productName,
  'description': instance.description,
  'model3DUrl': instance.model3DUrl,
  'model3DThumbnail': instance.model3DThumbnail,
  'hasVariants': instance.hasVariants,
  'hasCustomization': instance.hasCustomization,
  'isStockItem': instance.isStockItem,
  'isUSAMade': instance.isUSAMade,
  'manufacturingLocation': instance.manufacturingLocation,
  'minimumOrderQuantity': instance.minimumOrderQuantity,
  'standardProductionDays': instance.standardProductionDays,
  'rushProductionDays': instance.rushProductionDays,
  'isActive': instance.isActive,
  'categories': instance.categories,
  'variants': instance.variants,
  'images': instance.images,
  'placementAreas': instance.placementAreas,
  'decorationMethods': instance.decorationMethods,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

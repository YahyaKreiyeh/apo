import 'package:apo/features/home/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
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
  final bool isActive;
  final List<CategoryModel> categories;
  final List<VariantModel> variants;
  final List<ProductImageModel> images;
  final List<dynamic> placementAreas;
  final List<dynamic> decorationMethods;
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
    required this.isActive,
    required this.categories,
    required this.variants,
    required this.images,
    required this.placementAreas,
    required this.decorationMethods,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

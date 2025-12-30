import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  final int cartItemId;
  final int variantId;
  final String productName;
  final String productSKU;
  final String variantSKU;
  final String colorName;
  final String sizeName;
  final int? customizationTypeId;
  final String? customizationTypeName;
  final num unitPrice;
  final int quantity;
  final num lineTotal;
  final String imageUrl;
  final DateTime addedAt;

  const CartItemModel({
    required this.cartItemId,
    required this.variantId,
    required this.productName,
    required this.productSKU,
    required this.variantSKU,
    required this.colorName,
    required this.sizeName,
    required this.customizationTypeId,
    required this.customizationTypeName,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
    required this.imageUrl,
    required this.addedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

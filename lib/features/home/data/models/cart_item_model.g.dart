// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      cartItemId: (json['cartItemId'] as num).toInt(),
      variantId: (json['variantId'] as num).toInt(),
      productName: json['productName'] as String,
      productSKU: json['productSKU'] as String,
      variantSKU: json['variantSKU'] as String,
      colorName: json['colorName'] as String,
      sizeName: json['sizeName'] as String,
      unitPrice: json['unitPrice'] as num,
      quantity: (json['quantity'] as num).toInt(),
      lineTotal: json['lineTotal'] as num,
      imageUrl: json['imageUrl'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'cartItemId': instance.cartItemId,
      'variantId': instance.variantId,
      'productName': instance.productName,
      'productSKU': instance.productSKU,
      'variantSKU': instance.variantSKU,
      'colorName': instance.colorName,
      'sizeName': instance.sizeName,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'lineTotal': instance.lineTotal,
      'imageUrl': instance.imageUrl,
      'addedAt': instance.addedAt.toIso8601String(),
    };

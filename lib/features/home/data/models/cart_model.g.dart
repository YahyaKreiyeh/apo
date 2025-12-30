// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
  cartId: (json['cartId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  subtotalAmount: json['subtotalAmount'] as num,
  totalItems: (json['totalItems'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
  'cartId': instance.cartId,
  'userId': instance.userId,
  'items': instance.items,
  'subtotalAmount': instance.subtotalAmount,
  'totalItems': instance.totalItems,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

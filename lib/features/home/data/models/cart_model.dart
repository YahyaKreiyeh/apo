import 'package:apo/features/home/data/models/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int cartId;
  final int userId;
  final List<CartItemModel> items;
  final num subtotalAmount;
  final int totalItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CartModel({
    required this.cartId,
    required this.userId,
    required this.items,
    required this.subtotalAmount,
    required this.totalItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

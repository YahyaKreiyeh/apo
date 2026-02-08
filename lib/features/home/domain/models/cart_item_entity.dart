import 'package:apo/features/home/domain/models/cart_decoration_entity.dart';

class CartItemEntity {
  final int cartItemId;
  final int productId;
  final int variantId;
  final String name;
  final String productSku;
  final String variantSku;
  final String colorName;
  final String sizeName;
  final int? decorationTypeId;
  final String? decorationTypeName;
  final double? unitPrice;
  final double? lineTotal;
  final String imageUrl;
  final int quantity;
  final bool hasPersonalization;
  final DateTime? addedAt;
  final List<CartItemDecorationEntity> decorations;

  const CartItemEntity({
    required this.cartItemId,
    required this.productId,
    required this.variantId,
    required this.name,
    required this.productSku,
    required this.variantSku,
    required this.colorName,
    required this.sizeName,
    required this.decorationTypeId,
    required this.decorationTypeName,
    required this.unitPrice,
    required this.lineTotal,
    required this.imageUrl,
    required this.quantity,
    required this.hasPersonalization,
    required this.addedAt,
    required this.decorations,
  });

  CartItemEntity copyWith({
    int? cartItemId,
    int? variantId,
    int? quantity,
    double? unitPrice,
    double? lineTotal,
    String? imageUrl,
    String? name,
    String? productSku,
    String? variantSku,
    String? colorName,
    String? sizeName,
    int? decorationTypeId,
    String? decorationTypeName,
    bool? hasPersonalization,
    DateTime? addedAt,
    List<CartItemDecorationEntity>? decorations,
  }) {
    return CartItemEntity(
      cartItemId: cartItemId ?? this.cartItemId,
      productId: productId,
      variantId: variantId ?? this.variantId,
      name: name ?? this.name,
      productSku: productSku ?? this.productSku,
      variantSku: variantSku ?? this.variantSku,
      colorName: colorName ?? this.colorName,
      sizeName: sizeName ?? this.sizeName,
      decorationTypeId: decorationTypeId ?? this.decorationTypeId,
      decorationTypeName: decorationTypeName ?? this.decorationTypeName,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      hasPersonalization: hasPersonalization ?? this.hasPersonalization,
      addedAt: addedAt ?? this.addedAt,
      decorations: decorations ?? this.decorations,
    );
  }
}

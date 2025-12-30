class CartItemEntity {
  final int cartItemId;
  final int productId;
  final int variantId;
  final String name;
  final String productSku;
  final String variantSku;
  final String colorName;
  final String sizeName;
  final int? customizationTypeId;
  final String? customizationTypeName;
  final double? unitPrice;
  final double? lineTotal;
  final String imageUrl;
  final int quantity;
  final bool hasPersonalization;
  final DateTime? addedAt;

  const CartItemEntity({
    required this.cartItemId,
    required this.productId,
    required this.variantId,
    required this.name,
    required this.productSku,
    required this.variantSku,
    required this.colorName,
    required this.sizeName,
    required this.customizationTypeId,
    required this.customizationTypeName,
    required this.unitPrice,
    required this.lineTotal,
    required this.imageUrl,
    required this.quantity,
    required this.hasPersonalization,
    required this.addedAt,
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
    int? customizationTypeId,
    String? customizationTypeName,
    bool? hasPersonalization,
    DateTime? addedAt,
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
      customizationTypeId: customizationTypeId ?? this.customizationTypeId,
      customizationTypeName:
          customizationTypeName ?? this.customizationTypeName,
      unitPrice: unitPrice ?? this.unitPrice,
      lineTotal: lineTotal ?? this.lineTotal,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      hasPersonalization: hasPersonalization ?? this.hasPersonalization,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}

class CartItemEntity {
  final int productId;
  final String name;
  final String productSku;
  final double? unitPrice;
  final String imageUrl;
  final int quantity;
  final bool hasPersonalization;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.productSku,
    required this.unitPrice,
    required this.imageUrl,
    required this.quantity,
    required this.hasPersonalization,
  });

  CartItemEntity copyWith({
    int? quantity,
    double? unitPrice,
    String? imageUrl,
    String? name,
    String? productSku,
    bool? hasPersonalization,
  }) {
    return CartItemEntity(
      productId: productId,
      name: name ?? this.name,
      productSku: productSku ?? this.productSku,
      unitPrice: unitPrice ?? this.unitPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      hasPersonalization: hasPersonalization ?? this.hasPersonalization,
    );
  }
}

import 'package:apo/features/home/data/models/cart_item_model.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';

extension CartModelMapper on CartModel? {
  List<CartItemEntity> toEntities() {
    final cart = this;
    if (cart == null) return const [];
    return cart.items.map((item) => item.toEntity()).toList();
  }
}

extension CartItemModelMapper on CartItemModel? {
  CartItemEntity toEntity() {
    final item = this;
    if (item == null) {
      return const CartItemEntity(
        productId: 0,
        variantId: 0,
        name: '',
        productSku: '',
        unitPrice: 0,
        imageUrl: '',
        quantity: 0,
        hasPersonalization: false,
      );
    }
    return CartItemEntity(
      productId: 0,
      variantId: item.variantId,
      name: item.productName,
      productSku: item.productSKU,
      unitPrice: item.unitPrice.toDouble(),
      imageUrl: item.imageUrl,
      quantity: item.quantity,
      hasPersonalization: false,
    );
  }
}

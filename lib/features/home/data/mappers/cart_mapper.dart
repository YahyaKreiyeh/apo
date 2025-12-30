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
        cartItemId: 0,
        productId: 0,
        variantId: 0,
        name: '',
        productSku: '',
        variantSku: '',
        colorName: '',
        sizeName: '',
        customizationTypeId: null,
        customizationTypeName: null,
        unitPrice: 0,
        lineTotal: 0,
        imageUrl: '',
        quantity: 0,
        hasPersonalization: false,
        addedAt: null,
      );
    }
    return CartItemEntity(
      cartItemId: item.cartItemId,
      productId: 0,
      variantId: item.variantId,
      name: item.productName,
      productSku: item.productSKU,
      variantSku: item.variantSKU,
      colorName: item.colorName,
      sizeName: item.sizeName,
      customizationTypeId: item.customizationTypeId,
      customizationTypeName: item.customizationTypeName,
      unitPrice: item.unitPrice.toDouble(),
      lineTotal: item.lineTotal.toDouble(),
      imageUrl: item.imageUrl,
      quantity: item.quantity,
      hasPersonalization: false,
      addedAt: item.addedAt,
    );
  }
}

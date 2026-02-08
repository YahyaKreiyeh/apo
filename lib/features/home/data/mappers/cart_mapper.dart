import 'package:apo/features/home/data/mappers/master_detail_mapper.dart';
import 'package:apo/features/home/data/models/cart_item_model.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
import 'package:apo/features/home/domain/models/cart_decoration_entity.dart';
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
        decorationTypeId: null,
        decorationTypeName: null,
        unitPrice: 0,
        lineTotal: 0,
        imageUrl: '',
        quantity: 0,
        hasPersonalization: false,
        addedAt: null,
        decorations: [],
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
      decorationTypeId: item.decorationType?.id,
      decorationTypeName: item.decorationType?.name,
      unitPrice: item.unitPrice.toDouble(),
      lineTotal: item.lineTotal.toDouble(),
      imageUrl: item.imageUrl,
      quantity: item.quantity,
      hasPersonalization: false,
      addedAt: item.addedAt,
      decorations: item.decorations.map((decoration) => decoration.toEntity()).toList(),
    );
  }
}

extension CartItemDecorationModelMapper on CartItemDecorationModel? {
  CartItemDecorationEntity toEntity() {
    final decoration = this;
    if (decoration == null) {
      return CartItemDecorationEntity(
        cartItemDecorationId: 0,
        decorationId: 0,
        displayOrder: 0,
        createdAt: null,
        decoration: CartDecorationEntity(
          decorationId: 0,
          userId: 0,
          decorationType: null,
          decorationName: '',
          imageUrl: '',
          embOptions: null,
          embType: null,
          heatTransferType: null,
          heatTransferWidth: null,
          heatTransferHeight: null,
          screenPrintColors: null,
          screenPrintGarmentType: null,
          screenPrintLocation: null,
          leatherColor: null,
          leatherWidth: null,
          leatherHeight: null,
          patchesType: null,
          patchesWidth: null,
          patchesHeight: null,
          labelsType: null,
          labelsWidth: null,
          labelsHeight: null,
          createdAt: null,
          updatedAt: null,
        ),
      );
    }
    return CartItemDecorationEntity(
      cartItemDecorationId: decoration.cartItemDecorationId,
      decorationId: decoration.decorationId,
      displayOrder: decoration.displayOrder,
      createdAt: decoration.createdAt,
      decoration: decoration.decoration.toEntity(),
    );
  }
}

extension CartDecorationModelMapper on CartDecorationModel {
  CartDecorationEntity toEntity() {
    return CartDecorationEntity(
      decorationId: decorationId,
      userId: userId,
      decorationType: decorationType.toEntity(),
      decorationName: decorationName,
      imageUrl: imageUrl,
      embOptions: embOptions.toEntity(),
      embType: embType.toEntity(),
      heatTransferType: heatTransferType.toEntity(),
      heatTransferWidth: heatTransferWidth?.toDouble(),
      heatTransferHeight: heatTransferHeight?.toDouble(),
      screenPrintColors: screenPrintColors.toEntity(),
      screenPrintGarmentType: screenPrintGarmentType.toEntity(),
      screenPrintLocation: screenPrintLocation.toEntity(),
      leatherColor: leatherColor.toEntity(),
      leatherWidth: leatherWidth?.toDouble(),
      leatherHeight: leatherHeight?.toDouble(),
      patchesType: patchesType.toEntity(),
      patchesWidth: patchesWidth?.toDouble(),
      patchesHeight: patchesHeight?.toDouble(),
      labelsType: labelsType.toEntity(),
      labelsWidth: labelsWidth?.toDouble(),
      labelsHeight: labelsHeight?.toDouble(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

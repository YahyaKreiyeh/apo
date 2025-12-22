import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> with SafeEmitter<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(
    ProductDetailsEntity product, {
    int quantity = 1,
    bool hasPersonalization = false,
  }) {
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final existingIndex = state.items.indexWhere(
      (item) =>
          item.productId == product.productId &&
          item.hasPersonalization == hasPersonalization,
    );
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : '';
    final unitPrice = product.variants.isNotEmpty
        ? product.variants.first.basePrice
        : null;

    if (existingIndex == -1) {
      final updatedItems = [
        ...state.items,
        CartItemEntity(
          productId: product.productId,
          name: product.productName,
          productSku: product.productSKU,
          unitPrice: unitPrice,
          imageUrl: imageUrl,
          quantity: safeQuantity,
          hasPersonalization: hasPersonalization,
        ),
      ];
      safeEmit(state.copyWith(items: updatedItems));
      return;
    }

    final existing = state.items[existingIndex];
    final updatedItems = [...state.items];
    updatedItems[existingIndex] = existing.copyWith(
      quantity: existing.quantity + safeQuantity,
    );
    safeEmit(state.copyWith(items: updatedItems));
  }

  void removeProduct(int productId) {
    safeEmit(
      state.copyWith(
        items: state.items
            .where((item) => item.productId != productId)
            .toList(),
      ),
    );
  }

  void removeItem(int productId, bool hasPersonalization) {
    safeEmit(
      state.copyWith(
        items: state.items
            .where(
              (item) =>
                  item.productId != productId ||
                  item.hasPersonalization != hasPersonalization,
            )
            .toList(),
      ),
    );
  }

  void updateQuantity(int productId, bool hasPersonalization, int quantity) {
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final index = state.items.indexWhere(
      (item) =>
          item.productId == productId &&
          item.hasPersonalization == hasPersonalization,
    );
    if (index == -1) {
      return;
    }
    final updatedItems = [...state.items];
    updatedItems[index] = updatedItems[index].copyWith(quantity: safeQuantity);
    safeEmit(state.copyWith(items: updatedItems));
  }

  void clear() {
    safeEmit(state.copyWith(items: const []));
  }
}

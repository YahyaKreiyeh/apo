import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/usecases/add_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_cart_items_usecase.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> with SafeEmitter<CartState> {
  CartCubit(this._addCartItemUseCase, this._getCartItemsUseCase)
    : super(const CartState());

  final AddCartItemUseCase _addCartItemUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;

  Future<ApiResponseModel<List<CartItemEntity>>> loadCart() async {
    if (state.cartStatus.isLoading) {
      return const ApiResponseModel.success([]);
    }
    safeEmit(state.copyWith(cartStatus: const Result.loading()));
    final response = await _getCartItemsUseCase();
    response.when(
      success: (items) => safeEmit(
        state.copyWith(
          items: items,
          cartStatus: const Result.success(data: null),
        ),
      ),
      failure: (apiError) =>
          safeEmit(state.copyWith(cartStatus: Result.failure(error: apiError))),
    );
    return response;
  }

  Future<ApiResponseModel<void>> addProduct(
    ProductDetailsEntity product, {
    int quantity = 1,
    bool hasPersonalization = false,
    VariantEntity? selectedVariant,
  }) async {
    if (state.addStatus.isLoading) {
      return const ApiResponseModel.success(null);
    }
    safeEmit(state.copyWith(addStatus: const Result.loading()));
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final resolvedVariant =
        selectedVariant ??
        (product.variants.isNotEmpty ? product.variants.first : null);
    final variantId = resolvedVariant?.variantId ?? 0;
    final response = await _addCartItemUseCase(
      variantId: variantId,
      quantity: safeQuantity,
    );
    safeEmit(
      state.copyWith(
        addStatus: response.when(
          success: (_) => const Result.success(data: null),
          failure: (apiError) => Result.failure(error: apiError),
        ),
      ),
    );
    final isSuccess = response.when(
      success: (_) => true,
      failure: (_) => false,
    );
    if (isSuccess) {
      await loadCart();
    }
    return response;
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

  void removeItem(int productId, int variantId) {
    safeEmit(
      state.copyWith(
        items: state.items
            .where(
              (item) =>
                  item.productId != productId || item.variantId != variantId,
            )
            .toList(),
      ),
    );
  }

  void updateQuantity(int productId, int variantId, int quantity) {
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final index = state.items.indexWhere(
      (item) => item.productId == productId && item.variantId == variantId,
    );
    if (index == -1) {
      return;
    }
    final updatedItems = [...state.items];
    updatedItems[index] = updatedItems[index].copyWith(quantity: safeQuantity);
    safeEmit(state.copyWith(items: updatedItems));
  }

  void updatePersonalization(
    int productId,
    int variantId,
    bool hasPersonalization,
  ) {
    final index = state.items.indexWhere(
      (item) => item.productId == productId && item.variantId == variantId,
    );
    if (index == -1) {
      return;
    }
    final updatedItems = [...state.items];
    updatedItems[index] = updatedItems[index].copyWith(
      hasPersonalization: hasPersonalization,
    );
    safeEmit(state.copyWith(items: updatedItems));
  }

  void clear() {
    safeEmit(state.copyWith(items: const []));
  }
}

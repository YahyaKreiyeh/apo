import 'dart:async';
import 'dart:convert';

import 'package:apo/core/constants/shared_preferences_key.dart';
import 'package:apo/core/helpers/preferences_helper.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/usecases/add_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/delete_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_cart_items_usecase.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> with SafeEmitter<CartState> {
  CartCubit(
    this._addCartItemUseCase,
    this._getCartItemsUseCase,
    this._deleteCartItemUseCase,
  ) : super(const CartState());

  final AddCartItemUseCase _addCartItemUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;

  Future<ApiResponseModel<List<CartItemEntity>>> loadCart() async {
    if (state.cartStatus.isLoading) {
      return const ApiResponseModel.success([]);
    }
    safeEmit(state.copyWith(cartStatus: const Result.loading()));
    final isAuthenticated = await _isAuthenticated();
    if (!isAuthenticated) {
      final items = await _getLocalCartItems();
      safeEmit(
        state.copyWith(
          items: items,
          cartStatus: const Result.success(data: null),
        ),
      );
      return ApiResponseModel.success(items);
    }
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

  void addProductLocally(
    ProductDetailsEntity product, {
    int quantity = 1,
    bool hasPersonalization = false,
    VariantEntity? selectedVariant,
  }) {
    if (state.addStatus.isLoading) {
      return;
    }
    safeEmit(state.copyWith(addStatus: const Result.loading()));
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final resolvedVariant =
        selectedVariant ??
        (product.variants.isNotEmpty ? product.variants.first : null);
    final variantId = resolvedVariant?.variantId ?? 0;
    final imageUrl =
        resolvedVariant != null && resolvedVariant.images.isNotEmpty
        ? resolvedVariant.images.first.imageUrl
        : (product.images.isNotEmpty ? product.images.first.imageUrl : '');
    final existingIndex = state.items.indexWhere(
      (item) =>
          item.productId == product.productId && item.variantId == variantId,
    );
    final updatedItems = [...state.items];
    if (existingIndex == -1) {
      updatedItems.add(
        CartItemEntity(
          cartItemId: 0,
          productId: product.productId,
          variantId: variantId,
          name: product.productName,
          productSku: product.productSKU,
          variantSku: resolvedVariant?.variantSKU ?? '',
          colorName: resolvedVariant?.colorName ?? '',
          sizeName: resolvedVariant?.sizeType?.sizeName ?? '',
          customizationTypeId: null,
          customizationTypeName: null,
          unitPrice: resolvedVariant?.basePrice,
          lineTotal: null,
          imageUrl: imageUrl,
          quantity: safeQuantity,
          hasPersonalization: hasPersonalization,
          addedAt: null,
        ),
      );
    } else {
      final existing = updatedItems[existingIndex];
      updatedItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + safeQuantity,
        hasPersonalization: existing.hasPersonalization || hasPersonalization,
        unitPrice: resolvedVariant?.basePrice ?? existing.unitPrice,
        imageUrl: imageUrl.isNotEmpty ? imageUrl : existing.imageUrl,
        name: product.productName,
        productSku: product.productSKU,
      );
    }
    safeEmit(
      state.copyWith(
        items: updatedItems,
        addStatus: const Result.success(data: null),
      ),
    );
    unawaited(_persistLocalCartIfGuest(updatedItems));
  }

  void removeProduct(int productId) {
    final updatedItems = state.items
        .where((item) => item.productId != productId)
        .toList();
    safeEmit(state.copyWith(items: updatedItems));
    unawaited(_persistLocalCartIfGuest(updatedItems));
  }

  Future<void> removeItem(CartItemEntity item) async {
    final updatedItems = state.items.where((entry) {
      if (item.cartItemId > 0 && entry.cartItemId > 0) {
        return entry.cartItemId != item.cartItemId;
      }
      return entry.productId != item.productId ||
          entry.variantId != item.variantId;
    }).toList();
    safeEmit(state.copyWith(items: updatedItems));
    final isAuthenticated = await _isAuthenticated();
    if (!isAuthenticated) {
      unawaited(_persistLocalCartIfGuest(updatedItems));
      return;
    }
    if (item.cartItemId <= 0) {
      await loadCart();
      return;
    }
    final response = await _deleteCartItemUseCase(
      cartItemId: item.cartItemId,
    );
    response.when(
      success: (_) => unawaited(loadCart()),
      failure: (_) => unawaited(loadCart()),
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
    unawaited(_persistLocalCartIfGuest(updatedItems));
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
    unawaited(_persistLocalCartIfGuest(updatedItems));
  }

  void clear() {
    safeEmit(state.copyWith(items: const []));
    unawaited(_persistLocalCartIfGuest(const <CartItemEntity>[]));
  }

  Future<ApiResponseModel<void>> clearCart() async {
    clear();
    // TODO: Re-enable API clear when backend is ready.
    // final isAuthenticated = await _isAuthenticated();
    // if (!isAuthenticated) {
    //   clear();
    //   return const ApiResponseModel.success(null);
    // }
    // final response = await _clearCartUseCase();
    // response.when(
    //   success: (_) => safeEmit(
    //     state.copyWith(
    //       items: const [],
    //       cartStatus: const Result.success(data: null),
    //     ),
    //   ),
    //   failure: (apiError) => safeEmit(
    //     state.copyWith(cartStatus: Result.failure(error: apiError)),
    //   ),
    // );
    // return response;
    return const ApiResponseModel.success(null);
  }

  Future<bool> _isAuthenticated() async {
    final token = await SecureStorageHelper.getAuthToken();
    return token.trim().isNotEmpty;
  }

  Future<void> _persistLocalCartIfGuest(List<CartItemEntity> items) async {
    final isAuthenticated = await _isAuthenticated();
    if (isAuthenticated) return;
    await _setLocalCartItems(items);
  }

  Future<List<CartItemEntity>> _getLocalCartItems() async {
    final raw = PreferencesHelper.getString(SharedPreferencesKey.localCartKey);
    if (raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(_cartItemFromJson)
          .toList();
    } catch (_) {
      await PreferencesHelper.removeData(SharedPreferencesKey.localCartKey);
      return const [];
    }
  }

  Future<void> _setLocalCartItems(List<CartItemEntity> items) async {
    final payload = items.map(_cartItemToJson).toList();
    await PreferencesHelper.setData(
      SharedPreferencesKey.localCartKey,
      jsonEncode(payload),
    );
  }

  CartItemEntity _cartItemFromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      cartItemId: (json['cartItemId'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      variantId: (json['variantId'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      productSku: (json['productSku'] as String?) ?? '',
      variantSku: (json['variantSku'] as String?) ?? '',
      colorName: (json['colorName'] as String?) ?? '',
      sizeName: (json['sizeName'] as String?) ?? '',
      customizationTypeId: (json['customizationTypeId'] as num?)?.toInt(),
      customizationTypeName: json['customizationTypeName'] as String?,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      lineTotal: (json['lineTotal'] as num?)?.toDouble(),
      imageUrl: (json['imageUrl'] as String?) ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      hasPersonalization: (json['hasPersonalization'] as bool?) ?? false,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.tryParse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> _cartItemToJson(CartItemEntity item) {
    return {
      'cartItemId': item.cartItemId,
      'productId': item.productId,
      'variantId': item.variantId,
      'name': item.name,
      'productSku': item.productSku,
      'variantSku': item.variantSku,
      'colorName': item.colorName,
      'sizeName': item.sizeName,
      'customizationTypeId': item.customizationTypeId,
      'customizationTypeName': item.customizationTypeName,
      'unitPrice': item.unitPrice,
      'lineTotal': item.lineTotal,
      'imageUrl': item.imageUrl,
      'quantity': item.quantity,
      'hasPersonalization': item.hasPersonalization,
      'addedAt': item.addedAt?.toIso8601String(),
    };
  }
}

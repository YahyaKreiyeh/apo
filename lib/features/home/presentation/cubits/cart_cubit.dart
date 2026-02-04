import 'dart:async';
import 'dart:convert';

import 'package:apo/core/constants/shared_preferences_key.dart';
import 'package:apo/core/helpers/preferences_helper.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_type.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/usecases/add_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/delete_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_cart_items_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_master_detail_options_usecase.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> with SafeEmitter<CartState> {
  CartCubit(
    this._addCartItemUseCase,
    this._getCartItemsUseCase,
    this._deleteCartItemUseCase,
    this._getMasterDetailOptionsUseCase,
  ) : super(const CartState());

  final AddCartItemUseCase _addCartItemUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  final GetMasterDetailOptionsUseCase _getMasterDetailOptionsUseCase;

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

  Future<void> fetchDecorationTypeOptions() async {
    if (state.decorationTypeStatus.isLoading) return;
    safeEmit(state.copyWith(decorationTypeStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.decorationType,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            decorationTypeStatus: Result.success(data: data),
            decorationTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(decorationTypeStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchHeatTransferTypes() async {
    if (state.heatTransferTypeStatus.isLoading) return;
    safeEmit(state.copyWith(heatTransferTypeStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.heatTransferType,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            heatTransferTypeStatus: Result.success(data: data),
            heatTransferTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(heatTransferTypeStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchLeatherColors() async {
    if (state.leatherColorStatus.isLoading) return;
    safeEmit(state.copyWith(leatherColorStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.leatherColor,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            leatherColorStatus: Result.success(data: data),
            leatherColorOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(leatherColorStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchPatchTypes() async {
    if (state.patchTypeStatus.isLoading) return;
    safeEmit(state.copyWith(patchTypeStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.patchType,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            patchTypeStatus: Result.success(data: data),
            patchTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(patchTypeStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchLabelTypes() async {
    if (state.labelTypeStatus.isLoading) return;
    safeEmit(state.copyWith(labelTypeStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.labelType,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            labelTypeStatus: Result.success(data: data),
            labelTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(labelTypeStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchScreenPrintColors() async {
    if (state.screenPrintColorStatus.isLoading) return;
    safeEmit(state.copyWith(screenPrintColorStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.screenPrintColor,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            screenPrintColorStatus: Result.success(data: data),
            screenPrintColorOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(screenPrintColorStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchScreenPrintGarments() async {
    if (state.screenPrintGarmentStatus.isLoading) return;
    safeEmit(state.copyWith(screenPrintGarmentStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.screenPrintGarment,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            screenPrintGarmentStatus: Result.success(data: data),
            screenPrintGarmentOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(screenPrintGarmentStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchScreenPrintLocations() async {
    if (state.screenPrintLocationStatus.isLoading) return;
    safeEmit(state.copyWith(screenPrintLocationStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.screenPrintLocation,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            screenPrintLocationStatus: Result.success(data: data),
            screenPrintLocationOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(
            screenPrintLocationStatus: Result.failure(error: error),
          ),
        );
      },
    );
  }

  Future<void> fetchEmbOptions() async {
    if (state.embOptionsStatus.isLoading) return;
    safeEmit(state.copyWith(embOptionsStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.embOptions,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            embOptionsStatus: Result.success(data: data),
            embOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(embOptionsStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchEmbTypes() async {
    if (state.embTypesStatus.isLoading) return;
    safeEmit(state.copyWith(embTypesStatus: const Result.loading()));
    final response = await _getMasterDetailOptionsUseCase(
      MasterDetailType.embType,
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            embTypesStatus: Result.success(data: data),
            embTypes: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(state.copyWith(embTypesStatus: Result.failure(error: error)));
      },
    );
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
    final response = await _deleteCartItemUseCase(cartItemId: item.cartItemId);
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

  void updateDecorationType(
    int productId,
    int variantId,
    MasterDetailEntity option,
  ) {
    final index = state.items.indexWhere(
      (item) => item.productId == productId && item.variantId == variantId,
    );
    if (index == -1) {
      return;
    }
    final updatedItems = [...state.items];
    updatedItems[index] = updatedItems[index].copyWith(
      customizationTypeId: option.id,
      customizationTypeName: option.detailName,
    );
    safeEmit(state.copyWith(items: updatedItems));
    unawaited(_persistLocalCartIfGuest(updatedItems));
  }

  void addDecorationSelection(
    int productId,
    int variantId,
    MasterDetailEntity option,
  ) {
    final key = _itemKey(productId, variantId);
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(
      updatedMap[key] ?? const [],
    );
    updatedList.add(
      CartDecorationSelection(
        decorationTypeId: option.id,
        decorationTypeName: option.detailName,
        decorationTypeCode: option.detailCode,
      ),
    );
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void removeDecorationSelection(int productId, int variantId, int index) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing)
      ..removeAt(index);
    if (updatedList.isEmpty) {
      updatedMap.remove(key);
    } else {
      updatedMap[key] = updatedList;
    }
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationEmbOption(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(embOptionId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationEmbType(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(embTypeId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationHeatTransferType(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(heatTransferTypeId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationHeatTransferWidth(
    int productId,
    int variantId,
    int index,
    double? width,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(heatTransferWidth: width);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationHeatTransferHeight(
    int productId,
    int variantId,
    int index,
    double? height,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(heatTransferHeight: height);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationScreenPrintColor(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(screenPrintColorId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationScreenPrintGarment(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(screenPrintGarmentId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationScreenPrintLocation(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(screenPrintLocationId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLeatherColor(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] =
        updatedList[index].copyWith(leatherColorId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLeatherWidth(
    int productId,
    int variantId,
    int index,
    double? width,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(leatherWidth: width);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLeatherHeight(
    int productId,
    int variantId,
    int index,
    double? height,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(leatherHeight: height);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationPatchType(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(patchTypeId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationPatchWidth(
    int productId,
    int variantId,
    int index,
    double? width,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(patchWidth: width);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationPatchHeight(
    int productId,
    int variantId,
    int index,
    double? height,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(patchHeight: height);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLabelType(
    int productId,
    int variantId,
    int index,
    MasterDetailEntity? option,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(labelTypeId: option?.id);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLabelWidth(
    int productId,
    int variantId,
    int index,
    double? width,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(labelWidth: width);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationLabelHeight(
    int productId,
    int variantId,
    int index,
    double? height,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(labelHeight: height);
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationImagePath(
    int productId,
    int variantId,
    int index,
    String? imagePath,
  ) {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return;
    }
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    final updatedList = List<CartDecorationSelection>.from(existing);
    updatedList[index] = updatedList[index].copyWith(
      decorationImagePath: imagePath,
      clearDecorationImagePath: imagePath == null,
    );
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
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

  String _itemKey(int productId, int variantId) => '$productId-$variantId';
}

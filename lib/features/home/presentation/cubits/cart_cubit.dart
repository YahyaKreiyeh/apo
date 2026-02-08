import 'dart:async';
import 'dart:convert';

import 'package:apo/core/constants/shared_preferences_key.dart';
import 'package:apo/core/helpers/preferences_helper.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/decoration_create_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_type.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/usecases/add_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/create_decoration_usecase.dart';
import 'package:apo/features/home/domain/usecases/delete_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/delete_decoration_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_cart_items_usecase.dart';
import 'package:apo/features/home/domain/usecases/get_master_detail_options_usecase.dart';
import 'package:apo/features/home/domain/usecases/update_cart_item_usecase.dart';
import 'package:apo/features/home/domain/usecases/upload_decoration_image_usecase.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CartCubit extends Cubit<CartState> with SafeEmitter<CartState> {
  CartCubit(
    this._addCartItemUseCase,
    this._getCartItemsUseCase,
    this._deleteCartItemUseCase,
    this._getMasterDetailOptionsUseCase,
    this._uploadDecorationImageUseCase,
    this._createDecorationUseCase,
    this._updateCartItemUseCase,
    this._deleteDecorationUseCase,
  ) : super(const CartState());

  final AddCartItemUseCase _addCartItemUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  final GetMasterDetailOptionsUseCase _getMasterDetailOptionsUseCase;
  final UploadDecorationImageUseCase _uploadDecorationImageUseCase;
  final CreateDecorationUseCase _createDecorationUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final DeleteDecorationUseCase _deleteDecorationUseCase;

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
          decorationsByItem: _buildDecorationsByItem(items),
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
          decorationsByItem: _buildDecorationsByItem(items),
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
          decorationTypeId: null,
          decorationTypeName: null,
          unitPrice: resolvedVariant?.basePrice,
          lineTotal: null,
          imageUrl: imageUrl,
          quantity: safeQuantity,
          hasPersonalization: hasPersonalization,
          addedAt: null,
          decorations: const [],
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
      decorationTypeId: option.id,
      decorationTypeName: option.detailName,
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

  void setDecorationsForItem(
    int productId,
    int variantId,
    List<CartDecorationSelection> decorations,
  ) {
    final key = _itemKey(productId, variantId);
    final updatedMap = Map<String, List<CartDecorationSelection>>.from(
      state.decorationsByItem,
    );
    if (decorations.isEmpty) {
      updatedMap.remove(key);
    } else {
      updatedMap[key] = List<CartDecorationSelection>.from(decorations);
    }
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  Future<ApiResponseModel<void>> deleteDecorationSelection({
    required int productId,
    required int variantId,
    required int index,
  }) async {
    final key = _itemKey(productId, variantId);
    final existing = state.decorationsByItem[key];
    if (existing == null || index < 0 || index >= existing.length) {
      return const ApiResponseModel.success(null);
    }
    final decorationId = existing[index].decorationId ?? 0;
    removeDecorationSelection(productId, variantId, index);
    if (decorationId <= 0) {
      return const ApiResponseModel.success(null);
    }
    final response = await _deleteDecorationUseCase(decorationId: decorationId);
    response.when(
      success: (_) {},
      failure: (_) => unawaited(loadCart()),
    );
    return response;
  }

  Future<ApiResponseModel<void>> deleteDecorationById({
    required int decorationId,
  }) async {
    if (decorationId <= 0) {
      return const ApiResponseModel.success(null);
    }
    final response =
        await _deleteDecorationUseCase(decorationId: decorationId);
    response.when(
      success: (_) => unawaited(loadCart()),
      failure: (_) => unawaited(loadCart()),
    );
    return response;
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
      clearDecorationImageBytes: imagePath != null,
    );
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  void updateDecorationImageBytes(
    int productId,
    int variantId,
    int index,
    Uint8List? bytes,
    String? fileName,
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
      decorationImageBytes: bytes,
      decorationImageName: fileName,
      clearDecorationImageBytes: bytes == null,
    );
    updatedMap[key] = updatedList;
    safeEmit(state.copyWith(decorationsByItem: updatedMap));
  }

  Future<ApiResponseModel<void>> uploadDecorationImage({
    required int productId,
    required int variantId,
    required int index,
    required XFile image,
  }) async {
    final multipart = kIsWeb
        ? MultipartFile.fromBytes(
            await image.readAsBytes(),
            filename: image.name,
          )
        : await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          );
    final response = await _uploadDecorationImageUseCase(file: multipart);
    response.when(
      success: (uploaded) => updateDecorationImagePath(
        productId,
        variantId,
        index,
        uploaded.url,
      ),
      failure: (_) {},
    );
    return response.when(
      success: (_) => const ApiResponseModel.success(null),
      failure: (error) => ApiResponseModel.failure(error),
    );
  }

  Future<ApiResponseModel<void>> saveDecorationsForItem({
    required int cartItemId,
    required int quantity,
    required int productId,
    required int variantId,
  }) async {
    final key = _itemKey(productId, variantId);
    final decorations = state.decorationsByItem[key] ?? const [];
    if (decorations.isEmpty) {
      return const ApiResponseModel.success(null);
    }
    final createdDecorationIds = <int>[];
    ApiResponseModel<void> lastResponse =
        const ApiResponseModel.success(null);
    for (final decoration in decorations) {
      final resolvedDecoration = await _prepareDecorationForSave(decoration);
      if (resolvedDecoration == null) {
        lastResponse = ApiResponseModel.failure(
          const ApiErrorModel(title: AppStrings.unknownError),
        );
        break;
      }
      final payload = _buildDecorationPayload(resolvedDecoration);
      if (payload == null) {
        lastResponse = ApiResponseModel.failure(
          const ApiErrorModel(title: AppStrings.unknownError),
        );
        break;
      }
      final creationResponse = await _createDecorationUseCase(payload: payload);
      final isFailure = creationResponse.when(
        success: (_) => false,
        failure: (_) => true,
      );
      if (isFailure) {
        lastResponse = creationResponse.when(
          success: (_) => const ApiResponseModel.success(null),
          failure: (error) => ApiResponseModel.failure(error),
        );
        break;
      }
      final decorationId = creationResponse.when(
        success: (data) => data,
        failure: (_) => 0,
      );
      if (decorationId <= 0) {
        lastResponse = ApiResponseModel.failure(
          const ApiErrorModel(title: AppStrings.unknownError),
        );
        break;
      }
      createdDecorationIds.add(decorationId);
    }
    if (createdDecorationIds.isEmpty) {
      return lastResponse;
    }
    final updateResponse = await _updateCartItemUseCase(
      cartItemId: cartItemId,
      quantity: quantity,
      decorationIds: createdDecorationIds,
    );
    updateResponse.when(
      success: (_) => unawaited(loadCart()),
      failure: (_) {},
    );
    return updateResponse;
  }

  void clear() {
    safeEmit(state.copyWith(items: const [], decorationsByItem: const {}));
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
    final decorationTypeId =
        (json['decorationTypeId'] as num?)?.toInt() ??
        (json['customizationTypeId'] as num?)?.toInt();
    final decorationTypeName =
        (json['decorationTypeName'] as String?) ??
        (json['customizationTypeName'] as String?);
    return CartItemEntity(
      cartItemId: (json['cartItemId'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      variantId: (json['variantId'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      productSku: (json['productSku'] as String?) ?? '',
      variantSku: (json['variantSku'] as String?) ?? '',
      colorName: (json['colorName'] as String?) ?? '',
      sizeName: (json['sizeName'] as String?) ?? '',
      decorationTypeId: decorationTypeId,
      decorationTypeName: decorationTypeName,
      unitPrice: (json['unitPrice'] as num?)?.toDouble(),
      lineTotal: (json['lineTotal'] as num?)?.toDouble(),
      imageUrl: (json['imageUrl'] as String?) ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      hasPersonalization: (json['hasPersonalization'] as bool?) ?? false,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.tryParse(json['addedAt'] as String),
      decorations: const [],
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
      'decorationTypeId': item.decorationTypeId,
      'decorationTypeName': item.decorationTypeName,
      'unitPrice': item.unitPrice,
      'lineTotal': item.lineTotal,
      'imageUrl': item.imageUrl,
      'quantity': item.quantity,
      'hasPersonalization': item.hasPersonalization,
      'addedAt': item.addedAt?.toIso8601String(),
    };
  }

  String _itemKey(int productId, int variantId) => '$productId-$variantId';

  Future<CartDecorationSelection?> _prepareDecorationForSave(
    CartDecorationSelection decoration,
  ) async {
    if (decoration.decorationImageBytes != null) {
      final response = await _uploadDecorationImageUseCase(
        file: MultipartFile.fromBytes(
          decoration.decorationImageBytes!,
          filename: decoration.decorationImageName ?? 'decoration.jpg',
        ),
      );
      return response.when(
        success: (uploaded) => decoration.copyWith(
          decorationImagePath: uploaded.relativePath,
          clearDecorationImageBytes: true,
        ),
        failure: (_) => null,
      );
    }
    final imagePath = decoration.decorationImagePath;
    if (imagePath != null &&
        imagePath.isNotEmpty &&
        !imagePath.startsWith('http') &&
        !imagePath.startsWith('Content/')) {
      final response = await _uploadDecorationImageUseCase(
        file: await MultipartFile.fromFile(imagePath),
      );
      return response.when(
        success: (uploaded) => decoration.copyWith(
          decorationImagePath: uploaded.relativePath,
        ),
        failure: (_) => null,
      );
    }
    return decoration;
  }

  DecorationCreateEntity? _buildDecorationPayload(
    CartDecorationSelection decoration,
  ) {
    final decorationType = _decorationTypeValue(decoration.decorationTypeCode);
    if (decorationType == null || decoration.decorationTypeId <= 0) {
      return null;
    }
    return DecorationCreateEntity(
      decorationName: decorationType,
      decorationType: decorationType,
      decorationTypeId: decoration.decorationTypeId,
      embOptionsId: decoration.embOptionId,
      embTypeId: decoration.embTypeId,
      heatTransferTypeId: decoration.heatTransferTypeId,
      heatTransferWidth: decoration.heatTransferWidth,
      heatTransferHeight: decoration.heatTransferHeight,
      screenPrintColorsId: decoration.screenPrintColorId,
      screenPrintGarmentTypeId: decoration.screenPrintGarmentId,
      screenPrintLocationId: decoration.screenPrintLocationId,
      leatherColorId: decoration.leatherColorId,
      leatherWidth: decoration.leatherWidth,
      leatherHeight: decoration.leatherHeight,
      patchesTypeId: decoration.patchTypeId,
      patchesWidth: decoration.patchWidth,
      patchesHeight: decoration.patchHeight,
      labelsTypeId: decoration.labelTypeId,
      labelsWidth: decoration.labelWidth,
      labelsHeight: decoration.labelHeight,
      imageUrl: _normalizeDecorationImagePath(decoration.decorationImagePath),
    );
  }

  String? _decorationTypeValue(String? code) {
    if (code == null) return null;
    switch (code.toUpperCase()) {
      case 'EMBROIDERY':
        return 'embroidery';
      case 'HEAT_TRANSFER':
        return 'heatTransfer';
      case 'SCREEN_PRINT':
        return 'screenPrint';
      case 'LEATHER':
        return 'leather';
      case 'PATCHES':
        return 'patches';
      case 'LABELS':
        return 'labels';
      default:
        return null;
    }
  }

  String? _normalizeDecorationImagePath(String? path) {
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('http')) {
      final index = path.indexOf('Content/');
      return index == -1 ? null : path.substring(index);
    }
    if (path.startsWith('Content/')) return path;
    return null;
  }

  int? _idOrNull(int? value) => (value ?? 0) > 0 ? value : null;

  Map<String, List<CartDecorationSelection>> _buildDecorationsByItem(
    List<CartItemEntity> items,
  ) {
    final result = <String, List<CartDecorationSelection>>{};
    for (final item in items) {
      if (item.decorations.isEmpty) continue;
      final key = _itemKey(item.productId, item.variantId);
      final selections = <CartDecorationSelection>[];
      for (final cartDecoration in item.decorations) {
        final decoration = cartDecoration.decoration;
        final decorationType = decoration.decorationType;
        selections.add(
          CartDecorationSelection(
            decorationId: decoration.decorationId,
            decorationTypeId: decorationType?.id ?? 0,
            decorationTypeName:
                decorationType?.detailName ?? decoration.decorationName,
            decorationTypeCode: decorationType?.detailCode ?? '',
            embOptionId: _idOrNull(decoration.embOptions?.id),
            embTypeId: _idOrNull(decoration.embType?.id),
            heatTransferTypeId: _idOrNull(decoration.heatTransferType?.id),
            heatTransferWidth: decoration.heatTransferWidth,
            heatTransferHeight: decoration.heatTransferHeight,
            screenPrintColorId: _idOrNull(decoration.screenPrintColors?.id),
            screenPrintGarmentId:
                _idOrNull(decoration.screenPrintGarmentType?.id),
            screenPrintLocationId:
                _idOrNull(decoration.screenPrintLocation?.id),
            leatherColorId: _idOrNull(decoration.leatherColor?.id),
            leatherWidth: decoration.leatherWidth,
            leatherHeight: decoration.leatherHeight,
            patchTypeId: _idOrNull(decoration.patchesType?.id),
            patchWidth: decoration.patchesWidth,
            patchHeight: decoration.patchesHeight,
            labelTypeId: _idOrNull(decoration.labelsType?.id),
            labelWidth: decoration.labelsWidth,
            labelHeight: decoration.labelsHeight,
            decorationImagePath: decoration.imageUrl,
          ),
        );
      }
      result[key] = selections;
    }
    return result;
  }
}

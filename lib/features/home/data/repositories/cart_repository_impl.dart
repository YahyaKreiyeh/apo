import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/home/data/mappers/cart_mapper.dart';
import 'package:apo/features/home/data/mappers/decoration_create_mapper.dart';
import 'package:apo/features/home/data/mappers/master_detail_mapper.dart';
import 'package:apo/features/home/data/mappers/upload_image_mapper.dart';
import 'package:apo/features/home/data/models/cart_item_dto.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
import 'package:apo/features/home/data/models/master_detail_model.dart';
import 'package:apo/features/home/data/models/update_cart_item_dto.dart';
import 'package:apo/features/home/data/models/upload_image_model.dart';
import 'package:apo/features/home/data/models/decoration_create_response_model.dart';
import 'package:apo/features/home/data/services/cart_api_service.dart';
import 'package:apo/features/home/domain/models/decoration_create_entity.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';
import 'package:apo/features/home/domain/models/uploaded_image_entity.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';
import 'package:dio/dio.dart';

class CartRepositoryImpl extends BaseRepository implements CartRepository {
  CartRepositoryImpl(this._apiService);

  final CartApiService _apiService;

  @override
  Future<ApiResponseModel<void>> addCartItem({
    required int variantId,
    required int quantity,
  }) {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.addCartItem(
        CartItemDto(variantId: variantId, quantity: quantity),
      ),
    );
  }

  @override
  Future<ApiResponseModel<List<CartItemEntity>>> getCartItems() {
    return executeApiCall<List<CartItemEntity>, BaseApiResponse<CartModel>>(
      apiCall: _apiService.getCart,
      mapper: (response) => response.data.toEntities(),
    );
  }

  @override
  Future<ApiResponseModel<void>> deleteCartItem({required int cartItemId}) {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.deleteCartItem(cartItemId),
    );
  }

  @override
  Future<ApiResponseModel<void>> updateCartItem({
    required int cartItemId,
    required int quantity,
    required List<int> decorationIds,
  }) {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.updateCartItem(
        cartItemId,
        UpdateCartItemDto(quantity: quantity, decorationIds: decorationIds),
      ),
    );
  }

  @override
  Future<ApiResponseModel<void>> deleteDecoration({
    required int decorationId,
  }) {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.deleteDecoration(decorationId),
    );
  }

  @override
  Future<ApiResponseModel<void>> clearCart() {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.clearCart(),
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchDecorationTypeOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchDecorationTypeDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchHeatTransferTypeOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchHeatTransferTypeDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintColorOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchScreenPrintColorsDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintGarmentOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchScreenPrintGarmentDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintLocationOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchScreenPrintLocationDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchLeatherColorOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchLeatherColorDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchPatchTypeOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchPatchTypeDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchLabelTypeOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchLabelTypeDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchEmbOptions() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchEmbOptions,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchEmbTypes() {
    return executeApiCall<
      List<MasterDetailEntity>,
      BaseApiResponse<List<MasterDetailModel>>
    >(
      apiCall: _apiService.fetchEmbTypes,
      mapper: (response) {
        final options =
            (response.data ?? const <MasterDetailModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<MasterDetailEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }

  @override
  Future<ApiResponseModel<UploadedImageEntity>> uploadDecorationImage({
    required MultipartFile file,
  }) {
    return executeApiCall<
      UploadedImageEntity,
      BaseApiResponse<UploadImageModel>
    >(
      apiCall: () => _apiService.uploadDecorationImage('DECORATION', file),
      mapper: (response) => response.data.toEntity(),
    );
  }

  @override
  Future<ApiResponseModel<int>> createDecoration({
    required DecorationCreateEntity payload,
  }) {
    return executeApiCall<int, BaseApiResponse<DecorationCreateResponseModel>>(
      apiCall: () async => await _apiService.createDecoration(payload.toDto()),
      mapper: (response) {
        final data = response.data;
        return data?.decorationId ?? data?.id ?? 0;
      },
    );
  }
}

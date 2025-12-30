import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/home/data/mappers/cart_mapper.dart';
import 'package:apo/features/home/data/models/cart_item_dto.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
import 'package:apo/features/home/data/services/cart_api_service.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

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
  Future<ApiResponseModel<void>> clearCart() {
    return executeVoidApiCall(
      apiCall: () async => await _apiService.clearCart(),
    );
  }
}

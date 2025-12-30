import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';

abstract class CartRepository {
  Future<ApiResponseModel<void>> addCartItem({
    required int variantId,
    required int quantity,
  });

  Future<ApiResponseModel<List<CartItemEntity>>> getCartItems();

  Future<ApiResponseModel<void>> clearCart();
}

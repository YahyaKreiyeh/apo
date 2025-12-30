import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository _repository;

  const GetCartItemsUseCase(this._repository);

  Future<ApiResponseModel<List<CartItemEntity>>> call() {
    return _repository.getCartItems();
  }
}

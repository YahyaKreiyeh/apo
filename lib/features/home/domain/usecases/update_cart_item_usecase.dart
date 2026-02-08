import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class UpdateCartItemUseCase {
  final CartRepository _repository;

  const UpdateCartItemUseCase(this._repository);

  Future<ApiResponseModel<void>> call({
    required int cartItemId,
    required int quantity,
    required List<int> decorationIds,
  }) {
    return _repository.updateCartItem(
      cartItemId: cartItemId,
      quantity: quantity,
      decorationIds: decorationIds,
    );
  }
}

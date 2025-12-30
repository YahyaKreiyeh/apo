import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class AddCartItemUseCase {
  final CartRepository _repository;

  const AddCartItemUseCase(this._repository);

  Future<ApiResponseModel<void>> call({
    required int variantId,
    required int quantity,
  }) {
    return _repository.addCartItem(
      variantId: variantId,
      quantity: quantity,
    );
  }
}

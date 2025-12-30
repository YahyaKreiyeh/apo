import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class DeleteCartItemUseCase {
  const DeleteCartItemUseCase(this._repository);

  final CartRepository _repository;

  Future<ApiResponseModel<void>> call({required int cartItemId}) {
    return _repository.deleteCartItem(cartItemId: cartItemId);
  }
}

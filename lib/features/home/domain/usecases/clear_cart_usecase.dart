import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository _repository;

  const ClearCartUseCase(this._repository);

  Future<ApiResponseModel<void>> call() {
    return _repository.clearCart();
  }
}

import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class DeleteDecorationUseCase {
  final CartRepository _repository;

  const DeleteDecorationUseCase(this._repository);

  Future<ApiResponseModel<void>> call({required int decorationId}) {
    return _repository.deleteDecoration(decorationId: decorationId);
  }
}

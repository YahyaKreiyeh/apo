import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/decoration_create_entity.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';

class CreateDecorationUseCase {
  final CartRepository _repository;

  const CreateDecorationUseCase(this._repository);

  Future<ApiResponseModel<int>> call({
    required DecorationCreateEntity payload,
  }) {
    return _repository.createDecoration(payload: payload);
  }
}

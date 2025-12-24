import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/create_transfer_parameters.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';

class CreateTransferUseCase {
  CreateTransferUseCase(this._repository);

  final CheckoutRepository _repository;

  Future<ApiResponseModel<void>> call(CreateTransferParameters parameters) {
    return _repository.createTransfer(parameters: parameters);
  }
}

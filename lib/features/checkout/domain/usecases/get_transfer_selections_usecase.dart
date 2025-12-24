import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/transfer_entity.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';

class GetTransferSelectionsUseCase {
  GetTransferSelectionsUseCase(this._repository);

  final CheckoutRepository _repository;

  Future<ApiResponseModel<List<TransferEntity>>> call() {
    return _repository.fetchTransferSelections();
  }
}

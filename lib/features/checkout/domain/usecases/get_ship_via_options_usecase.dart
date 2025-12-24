import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';

class GetShipViaOptionsUseCase {
  GetShipViaOptionsUseCase(this._repository);

  final CheckoutRepository _repository;

  Future<ApiResponseModel<List<ShipViaOptionEntity>>> call() {
    return _repository.fetchShipViaOptions();
  }
}

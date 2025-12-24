import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutUseCase {
  final CheckoutRepository _repository;

  const CheckoutUseCase(this._repository);

  Future<ApiResponseModel<void>> call(QuoteRequestParameters parameters) {
    return _repository.checkout(parameters: parameters);
  }
}

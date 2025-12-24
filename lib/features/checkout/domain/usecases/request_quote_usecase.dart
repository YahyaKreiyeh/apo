import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';

class RequestQuoteUseCase {
  final CheckoutRepository _repository;

  const RequestQuoteUseCase(this._repository);

  Future<ApiResponseModel<void>> call(QuoteRequestParameters parameters) {
    return _repository.requestQuote(parameters: parameters);
  }
}

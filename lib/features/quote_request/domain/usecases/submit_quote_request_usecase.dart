import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/quote_request/domain/models/quote_request_parameters.dart';
import 'package:apo/features/quote_request/domain/repositories/quote_requests_repository.dart';

class SubmitQuoteRequestUseCase {
  final QuoteRequestsRepository _repository;

  const SubmitQuoteRequestUseCase(this._repository);

  Future<ApiResponseModel<void>> call(
    QuoteRequestParameters parameters,
  ) {
    return _repository.submitQuoteRequest(parameters: parameters);
  }
}

import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/quote_request/domain/models/quote_request_parameters.dart';

abstract class QuoteRequestsRepository {
  Future<ApiResponseModel<void>> submitQuoteRequest({
    required QuoteRequestParameters parameters,
  });
}

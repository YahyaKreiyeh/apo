import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/quote_request/data/mappers/quote_request_mapper.dart';
import 'package:apo/features/quote_request/data/services/quote_requests_api_service.dart';
import 'package:apo/features/quote_request/domain/models/quote_request_parameters.dart';
import 'package:apo/features/quote_request/domain/repositories/quote_requests_repository.dart';

class QuoteRequestsRepositoryImpl extends BaseRepository
    implements QuoteRequestsRepository {
  final QuoteRequestsApiService _apiService;

  QuoteRequestsRepositoryImpl(this._apiService);

  @override
  Future<ApiResponseModel<void>> submitQuoteRequest({
    required QuoteRequestParameters parameters,
  }) {
    return executeVoidApiCall(
      apiCall: () async {
        await _apiService.submitQuoteRequest(parameters.toDto());
      },
    );
  }
}

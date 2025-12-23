import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/quote_request/data/models/quote_request_dto.dart';
import 'package:apo/features/quote_request/data/models/quote_request_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'quote_requests_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class QuoteRequestsApiService {
  factory QuoteRequestsApiService(Dio dio) = _QuoteRequestsApiService;

  @POST(ApiConstants.quoteRequests)
  Future<BaseApiResponse<QuoteRequestResponseModel>> submitQuoteRequest(
    @Body() QuoteRequestDto body,
  );
}

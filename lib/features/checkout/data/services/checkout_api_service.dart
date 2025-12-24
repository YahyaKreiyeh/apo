import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/checkout/data/models/quote_request_dto.dart';
import 'package:apo/features/checkout/data/models/quote_request_response_model.dart';
import 'package:apo/features/checkout/data/models/ship_via_option_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CheckoutApiService {
  factory CheckoutApiService(Dio dio) = _CheckoutApiService;

  @POST(ApiConstants.quoteRequests)
  Future<BaseApiResponse<QuoteRequestResponseModel>> requestQuote(
    @Body() QuoteRequestDto body,
  );

  @POST(ApiConstants.checkout)
  Future<BaseApiResponse<void>> checkout(@Body() QuoteRequestDto body);

  @GET(ApiConstants.shipViaDetails)
  Future<BaseApiResponse<List<ShipViaOptionModel>>> fetchShipViaDetails();
}

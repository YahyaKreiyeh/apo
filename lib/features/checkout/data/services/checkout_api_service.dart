import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/checkout/data/models/create_transfer_dto.dart';
import 'package:apo/features/checkout/data/models/job_checkout_dto.dart';
import 'package:apo/features/checkout/data/models/quote_request_dto.dart';
import 'package:apo/features/checkout/data/models/quote_request_response_model.dart';
import 'package:apo/features/checkout/data/models/ship_via_option_model.dart';
import 'package:apo/features/checkout/data/models/transfer_model.dart';
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
  Future<BaseApiResponse<void>> checkout(@Body() JobCheckoutDto body);

  @GET(ApiConstants.shipViaDetails)
  Future<BaseApiResponse<List<ShipViaOptionModel>>> fetchShipViaDetails();

  @GET(ApiConstants.transfers)
  Future<BaseApiResponse<List<TransferModel>>> fetchTransfers();

  @GET(ApiConstants.transferTypeDetails)
  Future<BaseApiResponse<List<ShipViaOptionModel>>> fetchTransferTypeDetails();

  @GET(ApiConstants.sheetTypeDetails)
  Future<BaseApiResponse<List<ShipViaOptionModel>>> fetchSheetTypeDetails();

  @POST(ApiConstants.transfers)
  Future<BaseApiResponse<void>> createTransfer(
    @Body() CreateTransferDto body,
  );
}

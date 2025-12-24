import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';

abstract class CheckoutRepository {
  Future<ApiResponseModel<void>> requestQuote({
    required QuoteRequestParameters parameters,
  });

  Future<ApiResponseModel<void>> checkout({
    required QuoteRequestParameters parameters,
  });

  Future<ApiResponseModel<List<ShipViaOptionEntity>>> fetchShipViaOptions();
}

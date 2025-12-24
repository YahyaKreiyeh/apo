import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/checkout/domain/models/create_transfer_parameters.dart';
import 'package:apo/features/checkout/domain/models/job_checkout_parameters.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';
import 'package:apo/features/checkout/domain/models/transfer_entity.dart';

abstract class CheckoutRepository {
  Future<ApiResponseModel<void>> requestQuote({
    required QuoteRequestParameters parameters,
  });

  Future<ApiResponseModel<void>> checkout({
    required JobCheckoutParameters parameters,
  });

  Future<ApiResponseModel<List<ShipViaOptionEntity>>> fetchShipViaOptions();

  Future<ApiResponseModel<List<TransferEntity>>> fetchTransferSelections();

  Future<ApiResponseModel<List<ShipViaOptionEntity>>> fetchTransferTypeOptions();

  Future<ApiResponseModel<List<ShipViaOptionEntity>>> fetchSheetTypeOptions();

  Future<ApiResponseModel<void>> createTransfer({
    required CreateTransferParameters parameters,
  });
}

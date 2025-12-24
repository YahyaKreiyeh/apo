import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/checkout/data/mappers/quote_request_mapper.dart';
import 'package:apo/features/checkout/data/mappers/ship_via_option_mapper.dart';
import 'package:apo/features/checkout/data/models/ship_via_option_model.dart';
import 'package:apo/features/checkout/data/services/checkout_api_service.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';
import 'package:apo/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl extends BaseRepository
    implements CheckoutRepository {
  CheckoutRepositoryImpl(this._apiService);

  final CheckoutApiService _apiService;

  @override
  Future<ApiResponseModel<void>> requestQuote({
    required QuoteRequestParameters parameters,
  }) {
    return executeVoidApiCall(
      apiCall: () async {
        await _apiService.requestQuote(parameters.toDto());
      },
    );
  }

  @override
  Future<ApiResponseModel<void>> checkout({
    required QuoteRequestParameters parameters,
  }) {
    return executeVoidApiCall(
      apiCall: () async {
        await _apiService.checkout(parameters.toDto());
      },
    );
  }

  @override
  Future<ApiResponseModel<List<ShipViaOptionEntity>>> fetchShipViaOptions() {
    return executeApiCall<
      List<ShipViaOptionEntity>,
      BaseApiResponse<List<ShipViaOptionModel>>
    >(
      apiCall: _apiService.fetchShipViaDetails,
      mapper: (response) {
        final options =
            (response.data ?? const <ShipViaOptionModel>[])
                .where((option) => option.isActive)
                .map((option) => option.toEntity())
                .whereType<ShipViaOptionEntity>()
                .toList()
              ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return options;
      },
    );
  }
}

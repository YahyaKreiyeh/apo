import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/usecases/get_ship_via_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/request_quote_usecase.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/usecases/checkout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutState>
    with SafeEmitter<CheckoutState> {
  CheckoutCubit(
    this._requestQuoteUseCase,
    this._checkoutUseCase,
    this._getShipViaOptionsUseCase, {
    required CheckoutType type,
  }) : super(CheckoutState(type: type)) {
    if (type == CheckoutType.checkout) {
      Future.microtask(fetchShipViaOptions);
    }
  }

  final RequestQuoteUseCase _requestQuoteUseCase;
  final CheckoutUseCase _checkoutUseCase;
  final GetShipViaOptionsUseCase _getShipViaOptionsUseCase;

  void updateContact({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? companyName,
  }) {
    safeEmit(
      state.copyWith(
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        email: email ?? state.email,
        phone: phone ?? state.phone,
        companyName: companyName ?? state.companyName,
      ),
    );
  }

  void updateShippingAddress({
    String? line1,
    String? line2,
    String? city,
    String? region,
    String? zip,
  }) {
    safeEmit(
      state.copyWith(
        shipLine1: line1 ?? state.shipLine1,
        shipLine2: line2 ?? state.shipLine2,
        shipCity: city ?? state.shipCity,
        shipState: region ?? state.shipState,
        shipZip: zip ?? state.shipZip,
      ),
    );
  }

  void updateBillingAddress({
    String? line1,
    String? line2,
    String? city,
    String? region,
    String? zip,
  }) {
    safeEmit(
      state.copyWith(
        billLine1: line1 ?? state.billLine1,
        billLine2: line2 ?? state.billLine2,
        billCity: city ?? state.billCity,
        billState: region ?? state.billState,
        billZip: zip ?? state.billZip,
      ),
    );
  }

  void updateOrderDetails({
    String? notes,
    String? artworkDescription,
    String? numberOfLocations,
  }) {
    safeEmit(
      state.copyWith(
        customerNotes: notes ?? state.customerNotes,
        artworkDescription: artworkDescription ?? state.artworkDescription,
        numberOfLocations: numberOfLocations ?? state.numberOfLocations,
      ),
    );
  }

  void setDesiredShipDate(DateTime? date) {
    safeEmit(state.copyWith(desiredShipDate: date));
  }

  Future<void> fetchShipViaOptions() async {
    if (state.shipViaStatus.isLoading) return;
    safeEmit(state.copyWith(shipViaStatus: const Result.loading()));
    final response = await _getShipViaOptionsUseCase();
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            shipViaStatus: Result.success(data: data),
            shipViaOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(state.copyWith(shipViaStatus: Result.failure(error: error)));
      },
    );
  }

  void selectShipViaOption(String? code) {
    safeEmit(state.copyWith(selectedShipViaCode: code));
  }

  Future<void> submit({required List<CartItemEntity> items}) async {
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: const Result.loading()));
    final parameters = _buildParameters(items);
    final response = await _submitForType(parameters);
    response.when(
      success: (_) {
        safeEmit(state.copyWith(status: const Result.success(data: null)));
      },
      failure: (apiError) {
        safeEmit(state.copyWith(status: Result.failure(error: apiError)));
      },
    );
  }

  QuoteRequestParameters _buildParameters(List<CartItemEntity> items) {
    final shipDate = state.desiredShipDate ?? DateTime.now().toUtc();
    return QuoteRequestParameters(
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      email: state.email.trim(),
      phone: state.phone.trim(),
      companyName: state.companyName.trim(),
      items: items,
      shippingAddress: QuoteRequestAddressParameters(
        addressLine1: state.shipLine1.trim(),
        addressLine2: state.shipLine2.trim(),
        city: state.shipCity.trim(),
        state: state.shipState.trim(),
        zipCode: state.shipZip.trim(),
      ),
      billingAddress: QuoteRequestAddressParameters(
        addressLine1: state.billLine1.trim(),
        addressLine2: state.billLine2.trim(),
        city: state.billCity.trim(),
        state: state.billState.trim(),
        zipCode: state.billZip.trim(),
      ),
      customerNotes: state.customerNotes.trim(),
      metadata: QuoteRequestMetadataParameters(
        artworkDescription: state.artworkDescription.trim(),
        numLocations: int.tryParse(state.numberOfLocations.trim()) ?? 0,
        shipDate: shipDate,
      ),
    );
  }

  Future<ApiResponseModel<void>> _submitForType(
    QuoteRequestParameters parameters,
  ) {
    switch (state.type) {
      case CheckoutType.requestQuote:
        return _requestQuoteUseCase(parameters);
      case CheckoutType.checkout:
        return _checkoutUseCase(parameters);
    }
  }
}

import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/quote_request/domain/models/quote_request_parameters.dart';
import 'package:apo/features/quote_request/domain/usecases/submit_quote_request_usecase.dart';
import 'package:apo/features/quote_request/presentation/cubits/quote_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteRequestCubit extends Cubit<QuoteRequestState>
    with SafeEmitter<QuoteRequestState> {
  QuoteRequestCubit(this._submitQuoteRequestUseCase)
    : super(const QuoteRequestState());

  final SubmitQuoteRequestUseCase _submitQuoteRequestUseCase;

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
    String? country,
  }) {
    safeEmit(
      state.copyWith(
        shipLine1: line1 ?? state.shipLine1,
        shipLine2: line2 ?? state.shipLine2,
        shipCity: city ?? state.shipCity,
        shipState: region ?? state.shipState,
        shipZip: zip ?? state.shipZip,
        shipCountry: country ?? state.shipCountry,
      ),
    );
  }

  void updateBillingAddress({
    String? line1,
    String? line2,
    String? city,
    String? region,
    String? zip,
    String? country,
  }) {
    safeEmit(
      state.copyWith(
        billLine1: line1 ?? state.billLine1,
        billLine2: line2 ?? state.billLine2,
        billCity: city ?? state.billCity,
        billState: region ?? state.billState,
        billZip: zip ?? state.billZip,
        billCountry: country ?? state.billCountry,
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

  Future<void> submitQuoteRequest({required List<CartItemEntity> items}) async {
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: const Result.loading()));
    final shipDate = state.desiredShipDate ?? DateTime.now().toUtc();
    final parameters = QuoteRequestParameters(
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
        country: state.shipCountry.trim(),
        zipCode: state.shipZip.trim(),
      ),
      billingAddress: QuoteRequestAddressParameters(
        addressLine1: state.billLine1.trim(),
        addressLine2: state.billLine2.trim(),
        city: state.billCity.trim(),
        state: state.billState.trim(),
        country: state.billCountry.trim(),
        zipCode: state.billZip.trim(),
      ),
      customerNotes: state.customerNotes.trim(),
      metadata: QuoteRequestMetadataParameters(
        artworkDescription: state.artworkDescription.trim(),
        numLocations: int.tryParse(state.numberOfLocations.trim()) ?? 0,
        shipDate: shipDate,
      ),
    );
    final response = await _submitQuoteRequestUseCase(parameters);
    response.when(
      success: (_) {
        safeEmit(state.copyWith(status: const Result.success(data: null)));
      },
      failure: (apiError) {
        safeEmit(state.copyWith(status: Result.failure(error: apiError)));
      },
    );
  }
}

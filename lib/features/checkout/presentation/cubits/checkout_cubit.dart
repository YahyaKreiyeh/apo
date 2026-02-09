import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/domain/models/quote_request_parameters.dart';
import 'package:apo/features/checkout/domain/models/create_transfer_parameters.dart';
import 'package:apo/features/checkout/domain/models/job_checkout_parameters.dart';
import 'package:apo/features/checkout/domain/usecases/create_transfer_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_sheet_type_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_ship_via_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_transfer_type_options_usecase.dart';
import 'package:apo/features/checkout/domain/usecases/get_transfer_selections_usecase.dart';
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
    required GetTransferSelectionsUseCase getTransferSelectionsUseCase,
    required CreateTransferUseCase createTransferUseCase,
    required GetTransferTypeOptionsUseCase getTransferTypeOptionsUseCase,
    required GetSheetTypeOptionsUseCase getSheetTypeOptionsUseCase,
    required CheckoutType type,
  }) : _getTransferSelectionsUseCase = getTransferSelectionsUseCase,
       _createTransferUseCase = createTransferUseCase,
       _getTransferTypeOptionsUseCase = getTransferTypeOptionsUseCase,
       _getSheetTypeOptionsUseCase = getSheetTypeOptionsUseCase,
       super(CheckoutState(type: type));

  final RequestQuoteUseCase _requestQuoteUseCase;
  final CheckoutUseCase _checkoutUseCase;
  final GetShipViaOptionsUseCase _getShipViaOptionsUseCase;
  final GetTransferSelectionsUseCase _getTransferSelectionsUseCase;
  final CreateTransferUseCase _createTransferUseCase;
  final GetTransferTypeOptionsUseCase _getTransferTypeOptionsUseCase;
  final GetSheetTypeOptionsUseCase _getSheetTypeOptionsUseCase;

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

  void updateJobInformation({String? description, String? comment}) {
    safeEmit(
      state.copyWith(
        jobDescription: description ?? state.jobDescription,
        jobComment: comment ?? state.jobComment,
      ),
    );
  }

  void updateShippingInstructions(String instructions) {
    safeEmit(state.copyWith(shippingInstructions: instructions));
  }

  void setRequestedShipDate(DateTime? date) {
    safeEmit(state.copyWith(requestedShipDate: date));
  }

  void setMustShipByRequestedDate(bool value) {
    safeEmit(state.copyWith(mustShipByRequestedDate: value));
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

  Future<void> fetchTransferSelections() async {
    if (state.transfersStatus.isLoading) return;
    safeEmit(state.copyWith(transfersStatus: const Result.loading()));
    final response = await _getTransferSelectionsUseCase();
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            transfersStatus: Result.success(data: data),
            transferOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(state.copyWith(transfersStatus: Result.failure(error: error)));
      },
    );
  }

  Future<void> fetchTransferTypeOptions() async {
    if (state.transferTypeStatus.isLoading) return;
    safeEmit(state.copyWith(transferTypeStatus: const Result.loading()));
    final response = await _getTransferTypeOptionsUseCase();
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            transferTypeStatus: Result.success(data: data),
            transferTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(
          state.copyWith(transferTypeStatus: Result.failure(error: error)),
        );
      },
    );
  }

  Future<void> fetchSheetTypeOptions() async {
    if (state.sheetTypeStatus.isLoading) return;
    safeEmit(state.copyWith(sheetTypeStatus: const Result.loading()));
    final response = await _getSheetTypeOptionsUseCase();
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            sheetTypeStatus: Result.success(data: data),
            sheetTypeOptions: data,
          ),
        );
      },
      failure: (error) {
        safeEmit(state.copyWith(sheetTypeStatus: Result.failure(error: error)));
      },
    );
  }

  void toggleTransferSelection(int transferId) {
    final selected = List<int>.from(state.selectedTransferIds);
    if (selected.contains(transferId)) {
      selected.remove(transferId);
    } else {
      selected.add(transferId);
    }
    safeEmit(state.copyWith(selectedTransferIds: selected));
  }

  Future<ApiResponseModel<void>> createTransfer(
    CreateTransferParameters parameters,
  ) {
    return _createTransferUseCase(parameters);
  }

  Future<void> submit({
    required List<CartItemEntity> items,
    JobCheckoutParameters? checkoutParameters,
  }) async {
    if (state.status.isLoading) return;
    safeEmit(state.copyWith(status: const Result.loading()));
    final response = switch (state.type) {
      CheckoutType.requestQuote => await _requestQuoteUseCase(
        _buildQuoteParameters(items),
      ),
      CheckoutType.checkout => await _checkoutUseCase(
        checkoutParameters ?? _buildJobParameters(),
      ),
    };
    response.when(
      success: (_) {
        safeEmit(state.copyWith(status: const Result.success(data: null)));
      },
      failure: (apiError) {
        safeEmit(state.copyWith(status: Result.failure(error: apiError)));
      },
    );
  }

  QuoteRequestParameters _buildQuoteParameters(List<CartItemEntity> items) {
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
        country: 'USA',
        zipCode: state.shipZip.trim(),
      ),
      billingAddress: QuoteRequestAddressParameters(
        addressLine1: state.billLine1.trim(),
        addressLine2: state.billLine2.trim(),
        city: state.billCity.trim(),
        state: state.billState.trim(),
        country: 'USA',
        zipCode: state.billZip.trim(),
      ),
      customerNotes: state.customerNotes.trim(),
      metadata: QuoteRequestMetadataParameters(
        artworkDescription: state.artworkDescription.trim(),
        numLocations: int.tryParse(state.numberOfLocations.trim()) ?? 0,
      ),
    );
  }

  JobCheckoutParameters _buildJobParameters() {
    return JobCheckoutParameters(
      customerId: 0,
      isApolloProducts: true,
      shippingDetails: JobCheckoutShippingDetailsParameters(
        shipViaCode: state.selectedShipViaCode ?? '',
        streetAddress: state.shipLine1.trim(),
        aptBuildingSuite: state.shipLine2.trim(),
        city: state.shipCity.trim(),
        state: state.shipState.trim(),
        postalCode: state.shipZip.trim(),
        country: '',
        shippingInstructions: state.shippingInstructions.trim(),
      ),
      jobDescription: state.jobDescription.trim(),
      jobComment: state.jobComment.trim(),
      additionalServiceIds: const <int>[],
      customerNotes: state.customerNotes.trim(),
      orderDate: DateTime.now().toUtc(),
      orderType: '',
      customerNumber: '',
      customerPO: '',
      isBillingSameAsShipping: false,
    );
  }
}

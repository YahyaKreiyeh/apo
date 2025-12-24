import 'package:apo/core/models/result.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/domain/models/ship_via_option_entity.dart';
import 'package:apo/features/checkout/domain/models/transfer_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
abstract class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(Result.empty()) Result<void> status,
    @Default(CheckoutType.requestQuote) CheckoutType type,
    @Default(Result.empty()) Result<List<ShipViaOptionEntity>> shipViaStatus,
    @Default(<ShipViaOptionEntity>[]) List<ShipViaOptionEntity> shipViaOptions,
    String? selectedShipViaCode,
    @Default(Result.empty()) Result<List<ShipViaOptionEntity>>
    transferTypeStatus,
    @Default(<ShipViaOptionEntity>[]) List<ShipViaOptionEntity>
    transferTypeOptions,
    @Default(Result.empty()) Result<List<ShipViaOptionEntity>> sheetTypeStatus,
    @Default(<ShipViaOptionEntity>[]) List<ShipViaOptionEntity>
    sheetTypeOptions,
    @Default(Result.empty()) Result<List<TransferEntity>> transfersStatus,
    @Default(<TransferEntity>[]) List<TransferEntity> transferOptions,
    @Default(<int>[]) List<int> selectedTransferIds,
    @Default('') String jobDescription,
    @Default('') String jobComment,
    @Default('') String shippingInstructions,
    @Default(null) DateTime? requestedShipDate,
    @Default(false) bool mustShipByRequestedDate,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String companyName,
    @Default('') String shipLine1,
    @Default('') String shipLine2,
    @Default('') String shipCity,
    @Default('') String shipState,
    @Default('') String shipZip,
    @Default('') String billLine1,
    @Default('') String billLine2,
    @Default('') String billCity,
    @Default('') String billState,
    @Default('') String billZip,
    @Default('') String customerNotes,
    @Default('') String artworkDescription,
    @Default('1') String numberOfLocations,
    @Default(null) DateTime? desiredShipDate,
  }) = _CheckoutState;
}

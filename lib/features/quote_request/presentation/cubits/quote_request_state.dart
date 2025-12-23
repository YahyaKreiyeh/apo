import 'package:apo/core/models/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_request_state.freezed.dart';

@freezed
abstract class QuoteRequestState with _$QuoteRequestState {
  const factory QuoteRequestState({
    @Default(Result.empty()) Result<void> status,
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
    @Default('') String shipCountry,
    @Default('') String billLine1,
    @Default('') String billLine2,
    @Default('') String billCity,
    @Default('') String billState,
    @Default('') String billZip,
    @Default('') String billCountry,
    @Default('') String customerNotes,
    @Default('') String artworkDescription,
    @Default('1') String numberOfLocations,
    @Default(null) DateTime? desiredShipDate,
  }) = _QuoteRequestState;
}

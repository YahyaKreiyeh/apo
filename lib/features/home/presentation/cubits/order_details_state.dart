import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_state.freezed.dart';

@freezed
abstract class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(Result.empty()) Result<OrderDetailEntity> status,
    @Default(Result.empty()) Result<void> reorderStatus,
  }) = _OrderDetailsState;
}

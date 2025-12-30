import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders_state.freezed.dart';

@freezed
abstract class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(Result.empty()) Result<List<OrderEntity>> status,
    @Default(<OrderEntity>[]) List<OrderEntity> items,
    @Default(false) bool isRefreshing,
  }) = _OrdersState;
}

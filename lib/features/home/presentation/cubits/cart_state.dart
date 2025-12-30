import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItemEntity> items,
    @Default(Result.empty()) Result<void> addStatus,
    @Default(Result.empty()) Result<void> cartStatus,
  }) = _CartState;
}

extension CartStateX on CartState {
  int get totalItems =>
      items.fold<int>(0, (total, item) => total + item.quantity);
}

import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(Result.empty()) Result<List<ProductEntity>> status,
    @Default([]) List<ProductEntity> items,
    @Default(0) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _ProductsState;
}

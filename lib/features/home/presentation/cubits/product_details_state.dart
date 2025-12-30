import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_details_state.freezed.dart';

@freezed
abstract class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState({
    @Default(Result.empty()) Result<ProductDetailsEntity> status,
    @Default(1) int quantity,
    @Default(false) bool hasPersonalization,
    int? selectedVariantId,
  }) = _ProductDetailsState;
}

import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/usecases/get_product_details_usecase.dart';
import 'package:apo/features/home/presentation/cubits/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState>
    with SafeEmitter<ProductDetailsState> {
  final GetProductDetailsUseCase _getProductDetailsUseCase;
  final int productId;

  ProductDetailsCubit(this._getProductDetailsUseCase, {required this.productId})
      : super(const ProductDetailsState()) {
    load();
  }

  Future<void> load() async {
    safeEmit(state.copyWith(status: const Result.loading()));
    final response = await _getProductDetailsUseCase(productId);
    response.when(
      success: (data) =>
          safeEmit(state.copyWith(status: Result.success(data: data))),
      failure: (apiError) =>
          safeEmit(state.copyWith(status: Result.failure(error: apiError))),
    );
  }
}

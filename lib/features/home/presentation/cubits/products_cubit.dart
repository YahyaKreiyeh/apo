import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/products_parameters.dart';
import 'package:apo/features/home/domain/usecases/get_products_usecase.dart';
import 'package:apo/features/home/presentation/cubits/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState>
    with SafeEmitter<ProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit(this._getProductsUseCase) : super(const ProductsState());

  Future<void> loadInitial() async {
    if (state.status.isLoading) return;
    safeEmit(
      state.copyWith(
        status: const Result.loading(),
        items: const [],
        page: 0,
        hasMore: true,
        isLoadingMore: false,
      ),
    );
    final response = await _getProductsUseCase(
      const ProductsParameters(page: 1),
    );
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            status: Result.success(data: data),
            items: data,
            page: 1,
            hasMore: data.isNotEmpty,
            isLoadingMore: false,
          ),
        );
      },
      failure: (apiError) {
        safeEmit(
          state.copyWith(
            status: Result.failure(error: apiError),
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.status.isLoading || !state.hasMore) {
      return;
    }

    final nextPage = state.page + 1;
    safeEmit(state.copyWith(isLoadingMore: true));
    final response = await _getProductsUseCase(
      ProductsParameters(page: nextPage),
    );
    response.when(
      success: (data) {
        final updatedItems = [...state.items, ...data];
        safeEmit(
          state.copyWith(
            status: Result.success(data: updatedItems),
            items: updatedItems,
            page: nextPage,
            hasMore: data.isNotEmpty,
            isLoadingMore: false,
          ),
        );
      },
      failure: (apiError) {
        safeEmit(
          state.copyWith(
            status: Result.failure(error: apiError, data: state.items),
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}

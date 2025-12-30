import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/usecases/get_order_details_usecase.dart';
import 'package:apo/features/home/domain/usecases/reorder_order_usecase.dart';
import 'package:apo/features/home/presentation/cubits/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState>
    with SafeEmitter<OrderDetailsState> {
  OrderDetailsCubit(
    this._getOrderDetailsUseCase,
    this._reorderOrderUseCase, {
    required this.orderId,
  })
    : super(const OrderDetailsState()) {
    load();
  }

  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final ReorderOrderUseCase _reorderOrderUseCase;
  int orderId;

  Future<void> load() async {
    safeEmit(state.copyWith(status: const Result.loading()));
    final response = await _getOrderDetailsUseCase(orderId);
    response.when(
      success: (data) =>
          safeEmit(state.copyWith(status: Result.success(data: data))),
      failure: (apiError) =>
          safeEmit(state.copyWith(status: Result.failure(error: apiError))),
    );
  }

  Future<void> reorder() async {
    if (state.reorderStatus.isLoading) return;
    safeEmit(state.copyWith(reorderStatus: const Result.loading()));
    final response = await _reorderOrderUseCase(orderId);
    response.when(
      success: (data) {
        orderId = data.jobId;
        safeEmit(
          state.copyWith(
            status: Result.success(data: data),
            reorderStatus: const Result.success(data: null),
          ),
        );
      },
      failure: (apiError) {
        safeEmit(
          state.copyWith(
            reorderStatus: Result.failure(error: apiError),
          ),
        );
      },
    );
  }
}

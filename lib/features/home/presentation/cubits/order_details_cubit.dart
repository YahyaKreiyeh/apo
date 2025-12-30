import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/usecases/get_order_details_usecase.dart';
import 'package:apo/features/home/presentation/cubits/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState>
    with SafeEmitter<OrderDetailsState> {
  OrderDetailsCubit(this._getOrderDetailsUseCase, {required this.orderId})
    : super(const OrderDetailsState()) {
    load();
  }

  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  final int orderId;

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
}

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/networking/api_error_model.dart';
import 'package:apo/features/home/domain/usecases/get_orders_usecase.dart';
import 'package:apo/features/home/presentation/cubits/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersState> with SafeEmitter<OrdersState> {
  OrdersCubit(this._getOrdersUseCase) : super(const OrdersState());

  final GetOrdersUseCase _getOrdersUseCase;

  Future<void> loadOrders({bool isRefresh = false}) async {
    if (state.status.isLoading) return;
    final isAuthenticated = await _isAuthenticated();
    if (!isAuthenticated) {
      safeEmit(
        state.copyWith(
          status: Result.failure(
            error: ApiErrorModel(
              status: 401,
              title: AppStrings.ordersLoginRequired,
            ),
          ),
          items: const [],
          isRefreshing: false,
        ),
      );
      return;
    }
    if (isRefresh) {
      safeEmit(state.copyWith(isRefreshing: true));
    } else {
      safeEmit(
        state.copyWith(
          status: const Result.loading(),
          items: const [],
          isRefreshing: false,
        ),
      );
    }
    final response = await _getOrdersUseCase();
    response.when(
      success: (data) {
        safeEmit(
          state.copyWith(
            status: Result.success(data: data),
            items: data,
            isRefreshing: false,
          ),
        );
      },
      failure: (apiError) {
        safeEmit(
          state.copyWith(
            status: Result.failure(error: apiError, data: state.items),
            isRefreshing: false,
          ),
        );
      },
    );
  }

  Future<bool> _isAuthenticated() async {
    final token = await SecureStorageHelper.getAuthToken();
    return token.trim().isNotEmpty;
  }
}

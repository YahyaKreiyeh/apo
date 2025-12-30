import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';
import 'package:apo/features/home/domain/repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository _repository;

  const GetOrdersUseCase(this._repository);

  Future<ApiResponseModel<List<OrderEntity>>> call() {
    return _repository.getOrders();
  }
}

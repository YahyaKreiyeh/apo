import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';
import 'package:apo/features/home/domain/repositories/orders_repository.dart';

class ReorderOrderUseCase {
  final OrdersRepository _repository;

  const ReorderOrderUseCase(this._repository);

  Future<ApiResponseModel<OrderDetailEntity>> call(int id) {
    return _repository.reorder(id);
  }
}

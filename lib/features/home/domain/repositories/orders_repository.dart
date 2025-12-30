import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';

abstract class OrdersRepository {
  Future<ApiResponseModel<List<OrderEntity>>> getOrders();

  Future<ApiResponseModel<OrderDetailEntity>> getOrder(int id);
}

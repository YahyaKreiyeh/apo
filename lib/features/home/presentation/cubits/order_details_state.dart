import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';

class OrderDetailsState {
  final Result<OrderDetailEntity> status;

  const OrderDetailsState({this.status = const Result.empty()});

  OrderDetailsState copyWith({Result<OrderDetailEntity>? status}) {
    return OrderDetailsState(status: status ?? this.status);
  }
}

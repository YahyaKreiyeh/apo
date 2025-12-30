import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/home/data/mappers/job_detail_mapper.dart';
import 'package:apo/features/home/data/mappers/job_mapper.dart';
import 'package:apo/features/home/data/models/job_detail_model.dart';
import 'package:apo/features/home/data/models/job_model.dart';
import 'package:apo/features/home/data/services/orders_api_service.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';
import 'package:apo/features/home/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl extends BaseRepository implements OrdersRepository {
  OrdersRepositoryImpl(this._apiService);

  final OrdersApiService _apiService;

  @override
  Future<ApiResponseModel<List<OrderEntity>>> getOrders() {
    return executeApiCall<List<OrderEntity>, BaseApiResponse<List<JobModel>>>(
      apiCall: _apiService.getOrders,
      mapper: (response) {
        final jobs = response.data ?? const <JobModel>[];
        return jobs.map((job) => job.toEntity()).toList();
      },
    );
  }

  @override
  Future<ApiResponseModel<OrderDetailEntity>> getOrder(int id) {
    return executeApiCall<OrderDetailEntity, BaseApiResponse<JobDetailModel>>(
      apiCall: () => _apiService.getOrder(id),
      mapper: (response) => response.data.toEntity(),
    );
  }
}

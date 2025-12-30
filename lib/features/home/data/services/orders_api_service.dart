import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/home/data/models/job_detail_model.dart';
import 'package:apo/features/home/data/models/job_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'orders_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class OrdersApiService {
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @GET(ApiConstants.jobs)
  Future<BaseApiResponse<List<JobModel>>> getOrders();

  @GET('${ApiConstants.jobs}/{id}')
  Future<BaseApiResponse<JobDetailModel>> getOrder(@Path('id') int id);

  @POST('${ApiConstants.jobs}/{id}/reorder')
  Future<BaseApiResponse<JobDetailModel>> reorder(@Path('id') int id);
}

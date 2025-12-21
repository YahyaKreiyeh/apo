import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/home/data/models/product_details_model.dart';
import 'package:apo/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ProductsApiService {
  factory ProductsApiService(Dio dio) = _ProductsApiService;

  @GET(ApiConstants.products)
  Future<BaseApiResponse<List<ProductModel>>> getProducts(
    @Query('Page') int page,
  );

  @GET('${ApiConstants.products}/{id}')
  Future<BaseApiResponse<ProductDetailsModel>> getProductDetails(
    @Path('id') int id,
  );
}

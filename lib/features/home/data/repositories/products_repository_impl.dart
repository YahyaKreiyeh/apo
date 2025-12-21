import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/home/data/mappers/product_details_mapper.dart';
import 'package:apo/features/home/data/mappers/product_mapper.dart';
import 'package:apo/features/home/data/services/products_api_service.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/models/products_parameters.dart';
import 'package:apo/features/home/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends BaseRepository
    implements ProductsRepository {
  final ProductsApiService _apiService;

  ProductsRepositoryImpl(this._apiService);

  @override
  Future<ApiResponseModel<List<ProductEntity>>> getProducts({
    required ProductsParameters parameters,
  }) {
    return executeApiCall(
      apiCall: () => _apiService.getProducts(parameters.page),
      mapper: (response) =>
          response.data?.map((product) => product.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<ApiResponseModel<ProductDetailsEntity>> getProductDetails({
    required int productId,
  }) {
    return executeApiCall(
      apiCall: () => _apiService.getProductDetails(productId),
      mapper: (response) => response.data.toDomain(),
    );
  }
}

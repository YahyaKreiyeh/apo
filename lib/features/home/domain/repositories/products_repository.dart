import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/models/products_parameters.dart';

abstract class ProductsRepository {
  Future<ApiResponseModel<List<ProductEntity>>> getProducts({
    required ProductsParameters parameters,
  });
}

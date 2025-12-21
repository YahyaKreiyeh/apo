import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/domain/models/products_parameters.dart';
import 'package:apo/features/home/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<ApiResponseModel<List<ProductEntity>>> call(
    ProductsParameters parameters,
  ) {
    return _repository.getProducts(parameters: parameters);
  }
}

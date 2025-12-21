import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/repositories/products_repository.dart';

class GetProductDetailsUseCase {
  final ProductsRepository _repository;

  const GetProductDetailsUseCase(this._repository);

  Future<ApiResponseModel<ProductDetailsEntity>> call(int productId) {
    return _repository.getProductDetails(productId: productId);
  }
}

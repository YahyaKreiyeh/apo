import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/uploaded_image_entity.dart';
import 'package:apo/features/home/domain/repositories/cart_repository.dart';
import 'package:dio/dio.dart';

class UploadDecorationImageUseCase {
  final CartRepository _repository;

  const UploadDecorationImageUseCase(this._repository);

  Future<ApiResponseModel<UploadedImageEntity>> call({
    required MultipartFile file,
  }) {
    return _repository.uploadDecorationImage(file: file);
  }
}

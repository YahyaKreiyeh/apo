import 'package:apo/features/home/data/models/upload_image_model.dart';
import 'package:apo/features/home/domain/models/uploaded_image_entity.dart';

extension UploadImageModelMapper on UploadImageModel? {
  UploadedImageEntity toEntity() {
    return UploadedImageEntity(
      url: this?.url ?? '',
      relativePath: this?.relativePath ?? '',
      fileName: this?.fileName ?? '',
      originalFileName: this?.originalFileName ?? '',
      fileSize: this?.fileSize ?? 0,
    );
  }
}

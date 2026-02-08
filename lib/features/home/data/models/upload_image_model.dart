import 'package:json_annotation/json_annotation.dart';

part 'upload_image_model.g.dart';

@JsonSerializable()
class UploadImageModel {
  final String url;
  final String relativePath;
  final String fileName;
  final String originalFileName;
  final int fileSize;

  const UploadImageModel({
    required this.url,
    required this.relativePath,
    required this.fileName,
    required this.originalFileName,
    required this.fileSize,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      _$UploadImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageModelToJson(this);
}

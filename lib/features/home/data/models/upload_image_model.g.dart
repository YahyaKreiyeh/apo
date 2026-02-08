// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageModel _$UploadImageModelFromJson(Map<String, dynamic> json) =>
    UploadImageModel(
      url: json['url'] as String,
      relativePath: json['relativePath'] as String,
      fileName: json['fileName'] as String,
      originalFileName: json['originalFileName'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
    );

Map<String, dynamic> _$UploadImageModelToJson(UploadImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'relativePath': instance.relativePath,
      'fileName': instance.fileName,
      'originalFileName': instance.originalFileName,
      'fileSize': instance.fileSize,
    };

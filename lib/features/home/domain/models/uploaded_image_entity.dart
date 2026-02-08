class UploadedImageEntity {
  final String url;
  final String relativePath;
  final String fileName;
  final String originalFileName;
  final int fileSize;

  const UploadedImageEntity({
    required this.url,
    required this.relativePath,
    required this.fileName,
    required this.originalFileName,
    required this.fileSize,
  });
}

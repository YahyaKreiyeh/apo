class CreateTransferDto {
  final String transferCode;
  final String transferName;
  final String description;
  final String thumbnailUrl;
  final String designFileUrl;
  final String artworkUrl;
  final String artworkThumbnailUrl;
  final int transferTypeId;
  final int defaultSheetTypeId;

  const CreateTransferDto({
    required this.transferCode,
    required this.transferName,
    required this.description,
    required this.thumbnailUrl,
    required this.designFileUrl,
    required this.artworkUrl,
    required this.artworkThumbnailUrl,
    required this.transferTypeId,
    required this.defaultSheetTypeId,
  });

  Map<String, dynamic> toJson() => {
    'transferCode': transferCode,
    'transferName': transferName,
    'description': description,
    'thumbnailUrl': thumbnailUrl,
    'designFileUrl': designFileUrl,
    'artworkUrl': artworkUrl,
    'artworkThumbnailUrl': artworkThumbnailUrl,
    'transferTypeId': transferTypeId,
    'defaultSheetTypeId': defaultSheetTypeId,
  };
}

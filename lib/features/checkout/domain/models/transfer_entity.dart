class TransferEntity {
  final int transferId;
  final String transferType;
  final int transferTypeId;
  final int sheetTypeId;
  final int transferCatalogId;
  final String transferCode;
  final String transferName;
  final String artworkUrl;
  final String artworkThumbnailUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TransferEntity({
    required this.transferId,
    required this.transferType,
    required this.transferTypeId,
    required this.sheetTypeId,
    required this.transferCatalogId,
    required this.transferCode,
    required this.transferName,
    required this.artworkUrl,
    required this.artworkThumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}

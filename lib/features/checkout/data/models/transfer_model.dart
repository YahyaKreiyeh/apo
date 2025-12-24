import 'package:json_annotation/json_annotation.dart';

part 'transfer_model.g.dart';

@JsonSerializable()
class TransferModel {
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

  const TransferModel({
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

  factory TransferModel.fromJson(Map<String, dynamic> json) =>
      _$TransferModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransferModelToJson(this);
}

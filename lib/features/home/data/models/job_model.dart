import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  final int jobId;
  final String jobNumber;
  final String jobOwner;
  final String? poNumber;
  final String statusDetailName;
  final DateTime? requestedShipDate;
  final DateTime? createdAt;
  final num totalAmount;
  @JsonKey(name: 'items', fromJson: _itemsCountFromJson, includeToJson: false)
  final int itemsCount;
  @JsonKey(
    name: 'transfers',
    fromJson: _transfersCountFromJson,
    includeToJson: false,
  )
  final int transfersCount;

  const JobModel({
    required this.jobId,
    required this.jobNumber,
    required this.jobOwner,
    required this.poNumber,
    required this.statusDetailName,
    required this.requestedShipDate,
    required this.createdAt,
    required this.totalAmount,
    required this.itemsCount,
    required this.transfersCount,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);

  static int _itemsCountFromJson(Object? json) =>
      json is List ? json.length : 0;

  static int _transfersCountFromJson(Object? json) =>
      json is List ? json.length : 0;
}

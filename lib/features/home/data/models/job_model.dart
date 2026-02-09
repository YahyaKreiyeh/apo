import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  @JsonKey(fromJson: _toInt)
  final int jobId;
  @JsonKey(fromJson: _toStringOrEmpty)
  final String jobNumber;
  @JsonKey(readValue: _readJobOwner, fromJson: _toStringOrEmpty)
  final String jobOwner;
  @JsonKey(readValue: _readPoNumber, fromJson: _toNullableString)
  final String? poNumber;
  @JsonKey(readValue: _readStatusDetailName, fromJson: _toStringOrEmpty)
  final String statusDetailName;
  @JsonKey(readValue: _readRequestedShipDate, fromJson: _toDateTime)
  final DateTime? requestedShipDate;
  @JsonKey(fromJson: _toDateTime)
  final DateTime? createdAt;
  @JsonKey(fromJson: _toNum)
  final num totalAmount;
  @JsonKey(readValue: _readItems, fromJson: _toCount, includeToJson: false)
  final int itemsCount;
  @JsonKey(readValue: _readTransfers, fromJson: _toCount, includeToJson: false)
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

  static Object? _readJobOwner(Map<dynamic, dynamic> json, String _) =>
      json['jobOwner'] ?? json['customerName'] ?? json['customerNumber'];

  static Object? _readPoNumber(Map<dynamic, dynamic> json, String _) =>
      json['poNumber'] ?? json['customerPO'];

  static Object? _readStatusDetailName(Map<dynamic, dynamic> json, String _) {
    final statusDetailName = json['statusDetailName'];
    if (statusDetailName != null) return statusDetailName;
    final statusDetail = json['statusDetail'];
    if (statusDetail is Map<dynamic, dynamic>) {
      return statusDetail['detailName'] ?? statusDetail['detailCode'];
    }
    return json['status'];
  }

  static Object? _readRequestedShipDate(Map<dynamic, dynamic> json, String _) =>
      json['requestedShipDate'] ?? json['orderDate'];

  static Object? _readItems(Map<dynamic, dynamic> json, String _) =>
      json['items'] ?? json['itemsCount'];

  static Object? _readTransfers(Map<dynamic, dynamic> json, String _) =>
      json['transfers'] ?? json['transfersCount'];

  static int _toInt(Object? json) {
    if (json is num) return json.toInt();
    return int.tryParse(json?.toString() ?? '') ?? 0;
  }

  static num _toNum(Object? json) {
    if (json is num) return json;
    return num.tryParse(json?.toString() ?? '') ?? 0;
  }

  static String _toStringOrEmpty(Object? json) => json?.toString() ?? '';

  static String? _toNullableString(Object? json) {
    final value = json?.toString().trim();
    if (value == null || value.isEmpty || value.toLowerCase() == 'null') {
      return null;
    }
    return value;
  }

  static DateTime? _toDateTime(Object? json) {
    if (json is DateTime) return json;
    if (json is! String) return null;
    if (json.trim().isEmpty) return null;
    return DateTime.tryParse(json);
  }

  static int _toCount(Object? json) {
    if (json is List) return json.length;
    if (json is num) return json.toInt();
    return 0;
  }
}

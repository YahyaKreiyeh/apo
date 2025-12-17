import 'package:apo/core/constants/app_strings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String? type;
  final String? title;
  final int? status;
  final Map<String, List<String>>? errors;
  final String? traceId;
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Code')
  final int? code;
  @JsonKey(name: 'Status')
  final bool? responseStatus;
  @JsonKey(name: 'Data')
  final Map<String, dynamic>? data;

  const ApiErrorModel({
    this.type,
    this.title,
    this.status,
    this.errors,
    this.traceId,
    this.message,
    this.code,
    this.responseStatus,
    this.data,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String? firstErrorMessage() {
    if (errors == null || errors!.isEmpty) return null;
    final firstKey = errors!.keys.first;
    final list = errors![firstKey];
    if (list == null || list.isEmpty) return null;
    return list.first;
  }

  String get messageOrDefault {
    return firstErrorMessage() ?? title ?? message ?? AppStrings.unknownError;
  }

  bool get indicatesFailure {
    if (responseStatus != null) {
      return responseStatus == false;
    }
    if (code != null) {
      return code! >= 400;
    }
    if (status != null) {
      return status! >= 400;
    }
    return false;
  }
}

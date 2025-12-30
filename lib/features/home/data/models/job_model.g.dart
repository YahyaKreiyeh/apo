// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
  jobId: (json['jobId'] as num).toInt(),
  jobNumber: json['jobNumber'] as String,
  jobOwner: json['jobOwner'] as String,
  poNumber: json['poNumber'] as String?,
  statusDetailName: json['statusDetailName'] as String,
  requestedShipDate: json['requestedShipDate'] == null
      ? null
      : DateTime.parse(json['requestedShipDate'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  totalAmount: json['totalAmount'] as num,
  itemsCount: JobModel._itemsCountFromJson(json['items']),
  transfersCount: JobModel._transfersCountFromJson(json['transfers']),
);

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
  'jobId': instance.jobId,
  'jobNumber': instance.jobNumber,
  'jobOwner': instance.jobOwner,
  'poNumber': instance.poNumber,
  'statusDetailName': instance.statusDetailName,
  'requestedShipDate': instance.requestedShipDate?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'totalAmount': instance.totalAmount,
};

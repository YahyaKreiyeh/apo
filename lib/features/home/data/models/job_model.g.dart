// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
  jobId: JobModel._toInt(json['jobId']),
  jobNumber: JobModel._toStringOrEmpty(json['jobNumber']),
  jobOwner: JobModel._toStringOrEmpty(JobModel._readJobOwner(json, 'jobOwner')),
  poNumber: JobModel._toNullableString(
    JobModel._readPoNumber(json, 'poNumber'),
  ),
  statusDetailName: JobModel._toStringOrEmpty(
    JobModel._readStatusDetailName(json, 'statusDetailName'),
  ),
  requestedShipDate: JobModel._toDateTime(
    JobModel._readRequestedShipDate(json, 'requestedShipDate'),
  ),
  createdAt: JobModel._toDateTime(json['createdAt']),
  totalAmount: JobModel._toNum(json['totalAmount']),
  itemsCount: JobModel._toCount(JobModel._readItems(json, 'itemsCount')),
  transfersCount: JobModel._toCount(
    JobModel._readTransfers(json, 'transfersCount'),
  ),
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

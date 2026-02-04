import 'package:json_annotation/json_annotation.dart';

part 'master_detail_model.g.dart';

@JsonSerializable()
class MasterDetailModel {
  @JsonKey(name: 'masterDetailId')
  final int id;
  final String detailName;
  final String detailCode;
  final int displayOrder;
  final bool isActive;

  const MasterDetailModel({
    required this.id,
    required this.detailName,
    required this.detailCode,
    required this.displayOrder,
    required this.isActive,
  });

  factory MasterDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MasterDetailModelToJson(this);
}

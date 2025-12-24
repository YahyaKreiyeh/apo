import 'package:json_annotation/json_annotation.dart';

part 'ship_via_option_model.g.dart';

@JsonSerializable()
class ShipViaOptionModel {
  @JsonKey(name: 'masterDetailId')
  final int id;
  final String detailName;
  final String detailCode;
  final int displayOrder;
  final bool isActive;

  const ShipViaOptionModel({
    required this.id,
    required this.detailName,
    required this.detailCode,
    required this.displayOrder,
    required this.isActive,
  });

  factory ShipViaOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ShipViaOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShipViaOptionModelToJson(this);

}

import 'package:json_annotation/json_annotation.dart';

part 'decoration_create_response_model.g.dart';

@JsonSerializable()
class DecorationCreateResponseModel {
  final int? decorationId;
  final int? id;

  const DecorationCreateResponseModel({this.decorationId, this.id});

  factory DecorationCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DecorationCreateResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DecorationCreateResponseModelToJson(this);
}

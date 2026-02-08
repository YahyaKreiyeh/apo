import 'package:json_annotation/json_annotation.dart';

part 'update_cart_item_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdateCartItemDto {
  final int quantity;
  final List<int> decorationIds;

  const UpdateCartItemDto({
    required this.quantity,
    required this.decorationIds,
  });

  factory UpdateCartItemDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCartItemDtoToJson(this);
}

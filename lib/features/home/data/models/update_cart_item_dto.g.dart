// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCartItemDto _$UpdateCartItemDtoFromJson(Map<String, dynamic> json) =>
    UpdateCartItemDto(
      quantity: (json['quantity'] as num).toInt(),
      decorationIds: (json['decorationIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UpdateCartItemDtoToJson(UpdateCartItemDto instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'decorationIds': instance.decorationIds,
    };

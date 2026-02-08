// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      cartItemId: (json['cartItemId'] as num).toInt(),
      variantId: (json['variantId'] as num).toInt(),
      productName: json['productName'] as String,
      productSKU: json['productSKU'] as String,
      variantSKU: json['variantSKU'] as String,
      colorName: json['colorName'] as String,
      sizeName: json['sizeName'] as String,
      decorationType: json['decorationType'] == null
          ? null
          : CartDecorationTypeModel.fromJson(
              json['decorationType'] as Map<String, dynamic>,
            ),
      unitPrice: json['unitPrice'] as num,
      quantity: (json['quantity'] as num).toInt(),
      lineTotal: json['lineTotal'] as num,
      imageUrl: json['imageUrl'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      decorations:
          (json['decorations'] as List<dynamic>?)
              ?.map(
                (e) =>
                    CartItemDecorationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'cartItemId': instance.cartItemId,
      'variantId': instance.variantId,
      'productName': instance.productName,
      'productSKU': instance.productSKU,
      'variantSKU': instance.variantSKU,
      'colorName': instance.colorName,
      'sizeName': instance.sizeName,
      'decorationType': instance.decorationType,
      'unitPrice': instance.unitPrice,
      'quantity': instance.quantity,
      'lineTotal': instance.lineTotal,
      'imageUrl': instance.imageUrl,
      'addedAt': instance.addedAt.toIso8601String(),
      'decorations': instance.decorations,
    };

CartDecorationTypeModel _$CartDecorationTypeModelFromJson(
  Map<String, dynamic> json,
) => CartDecorationTypeModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$CartDecorationTypeModelToJson(
  CartDecorationTypeModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

CartItemDecorationModel _$CartItemDecorationModelFromJson(
  Map<String, dynamic> json,
) => CartItemDecorationModel(
  cartItemDecorationId: (json['cartItemDecorationId'] as num).toInt(),
  decorationId: (json['decorationId'] as num).toInt(),
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  decoration: CartDecorationModel.fromJson(
    json['decoration'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CartItemDecorationModelToJson(
  CartItemDecorationModel instance,
) => <String, dynamic>{
  'cartItemDecorationId': instance.cartItemDecorationId,
  'decorationId': instance.decorationId,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'decoration': instance.decoration,
};

CartDecorationModel _$CartDecorationModelFromJson(
  Map<String, dynamic> json,
) => CartDecorationModel(
  decorationId: (json['decorationId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  decorationType: json['decorationType'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['decorationType'] as Map<String, dynamic>,
        ),
  decorationName: json['decorationName'] as String,
  imageUrl: json['imageUrl'] as String,
  embOptions: json['embOptions'] == null
      ? null
      : MasterDetailModel.fromJson(json['embOptions'] as Map<String, dynamic>),
  embType: json['embType'] == null
      ? null
      : MasterDetailModel.fromJson(json['embType'] as Map<String, dynamic>),
  heatTransferType: json['heatTransferType'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['heatTransferType'] as Map<String, dynamic>,
        ),
  heatTransferWidth: json['heatTransferWidth'] as num?,
  heatTransferHeight: json['heatTransferHeight'] as num?,
  screenPrintColors: json['screenPrintColors'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['screenPrintColors'] as Map<String, dynamic>,
        ),
  screenPrintGarmentType: json['screenPrintGarmentType'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['screenPrintGarmentType'] as Map<String, dynamic>,
        ),
  screenPrintLocation: json['screenPrintLocation'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['screenPrintLocation'] as Map<String, dynamic>,
        ),
  leatherColor: json['leatherColor'] == null
      ? null
      : MasterDetailModel.fromJson(
          json['leatherColor'] as Map<String, dynamic>,
        ),
  leatherWidth: json['leatherWidth'] as num?,
  leatherHeight: json['leatherHeight'] as num?,
  patchesType: json['patchesType'] == null
      ? null
      : MasterDetailModel.fromJson(json['patchesType'] as Map<String, dynamic>),
  patchesWidth: json['patchesWidth'] as num?,
  patchesHeight: json['patchesHeight'] as num?,
  labelsType: json['labelsType'] == null
      ? null
      : MasterDetailModel.fromJson(json['labelsType'] as Map<String, dynamic>),
  labelsWidth: json['labelsWidth'] as num?,
  labelsHeight: json['labelsHeight'] as num?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CartDecorationModelToJson(
  CartDecorationModel instance,
) => <String, dynamic>{
  'decorationId': instance.decorationId,
  'userId': instance.userId,
  'decorationType': instance.decorationType,
  'decorationName': instance.decorationName,
  'imageUrl': instance.imageUrl,
  'embOptions': instance.embOptions,
  'embType': instance.embType,
  'heatTransferType': instance.heatTransferType,
  'heatTransferWidth': instance.heatTransferWidth,
  'heatTransferHeight': instance.heatTransferHeight,
  'screenPrintColors': instance.screenPrintColors,
  'screenPrintGarmentType': instance.screenPrintGarmentType,
  'screenPrintLocation': instance.screenPrintLocation,
  'leatherColor': instance.leatherColor,
  'leatherWidth': instance.leatherWidth,
  'leatherHeight': instance.leatherHeight,
  'patchesType': instance.patchesType,
  'patchesWidth': instance.patchesWidth,
  'patchesHeight': instance.patchesHeight,
  'labelsType': instance.labelsType,
  'labelsWidth': instance.labelsWidth,
  'labelsHeight': instance.labelsHeight,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

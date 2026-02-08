import 'package:apo/features/home/data/models/master_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  final int cartItemId;
  final int variantId;
  final String productName;
  final String productSKU;
  final String variantSKU;
  final String colorName;
  final String sizeName;
  final CartDecorationTypeModel? decorationType;
  final num unitPrice;
  final int quantity;
  final num lineTotal;
  final String imageUrl;
  final DateTime addedAt;
  @JsonKey(defaultValue: <CartItemDecorationModel>[])
  final List<CartItemDecorationModel> decorations;

  const CartItemModel({
    required this.cartItemId,
    required this.variantId,
    required this.productName,
    required this.productSKU,
    required this.variantSKU,
    required this.colorName,
    required this.sizeName,
    required this.decorationType,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
    required this.imageUrl,
    required this.addedAt,
    required this.decorations,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

@JsonSerializable()
class CartDecorationTypeModel {
  final int id;
  final String name;

  const CartDecorationTypeModel({required this.id, required this.name});

  factory CartDecorationTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CartDecorationTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDecorationTypeModelToJson(this);
}

@JsonSerializable()
class CartItemDecorationModel {
  final int cartItemDecorationId;
  final int decorationId;
  final int displayOrder;
  final DateTime createdAt;
  final CartDecorationModel decoration;

  const CartItemDecorationModel({
    required this.cartItemDecorationId,
    required this.decorationId,
    required this.displayOrder,
    required this.createdAt,
    required this.decoration,
  });

  factory CartItemDecorationModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemDecorationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemDecorationModelToJson(this);
}

@JsonSerializable()
class CartDecorationModel {
  final int decorationId;
  final int userId;
  final MasterDetailModel? decorationType;
  final String decorationName;
  final String imageUrl;
  final MasterDetailModel? embOptions;
  final MasterDetailModel? embType;
  final MasterDetailModel? heatTransferType;
  final num? heatTransferWidth;
  final num? heatTransferHeight;
  final MasterDetailModel? screenPrintColors;
  final MasterDetailModel? screenPrintGarmentType;
  final MasterDetailModel? screenPrintLocation;
  final MasterDetailModel? leatherColor;
  final num? leatherWidth;
  final num? leatherHeight;
  final MasterDetailModel? patchesType;
  final num? patchesWidth;
  final num? patchesHeight;
  final MasterDetailModel? labelsType;
  final num? labelsWidth;
  final num? labelsHeight;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartDecorationModel({
    required this.decorationId,
    required this.userId,
    required this.decorationType,
    required this.decorationName,
    required this.imageUrl,
    required this.embOptions,
    required this.embType,
    required this.heatTransferType,
    required this.heatTransferWidth,
    required this.heatTransferHeight,
    required this.screenPrintColors,
    required this.screenPrintGarmentType,
    required this.screenPrintLocation,
    required this.leatherColor,
    required this.leatherWidth,
    required this.leatherHeight,
    required this.patchesType,
    required this.patchesWidth,
    required this.patchesHeight,
    required this.labelsType,
    required this.labelsWidth,
    required this.labelsHeight,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartDecorationModel.fromJson(Map<String, dynamic> json) =>
      _$CartDecorationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDecorationModelToJson(this);
}

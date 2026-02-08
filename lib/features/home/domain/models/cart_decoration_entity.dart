import 'package:apo/features/home/domain/models/master_detail_entity.dart';

class CartItemDecorationEntity {
  final int cartItemDecorationId;
  final int decorationId;
  final int displayOrder;
  final DateTime? createdAt;
  final CartDecorationEntity decoration;

  const CartItemDecorationEntity({
    required this.cartItemDecorationId,
    required this.decorationId,
    required this.displayOrder,
    required this.createdAt,
    required this.decoration,
  });
}

class CartDecorationEntity {
  final int decorationId;
  final int userId;
  final MasterDetailEntity? decorationType;
  final String decorationName;
  final String imageUrl;
  final MasterDetailEntity? embOptions;
  final MasterDetailEntity? embType;
  final MasterDetailEntity? heatTransferType;
  final double? heatTransferWidth;
  final double? heatTransferHeight;
  final MasterDetailEntity? screenPrintColors;
  final MasterDetailEntity? screenPrintGarmentType;
  final MasterDetailEntity? screenPrintLocation;
  final MasterDetailEntity? leatherColor;
  final double? leatherWidth;
  final double? leatherHeight;
  final MasterDetailEntity? patchesType;
  final double? patchesWidth;
  final double? patchesHeight;
  final MasterDetailEntity? labelsType;
  final double? labelsWidth;
  final double? labelsHeight;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CartDecorationEntity({
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
}

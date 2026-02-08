import 'package:apo/core/models/result.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItemEntity> items,
    @Default(Result.empty()) Result<void> addStatus,
    @Default(Result.empty()) Result<void> cartStatus,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> decorationTypeStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> decorationTypeOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> heatTransferTypeStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> heatTransferTypeOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> screenPrintColorStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> screenPrintColorOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> screenPrintGarmentStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> screenPrintGarmentOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> screenPrintLocationStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> screenPrintLocationOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> leatherColorStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> leatherColorOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> patchTypeStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> patchTypeOptions,
    @Default(Result.empty())
    Result<List<MasterDetailEntity>> labelTypeStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> labelTypeOptions,
    @Default(Result.empty()) Result<List<MasterDetailEntity>> embOptionsStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> embOptions,
    @Default(Result.empty()) Result<List<MasterDetailEntity>> embTypesStatus,
    @Default(<MasterDetailEntity>[]) List<MasterDetailEntity> embTypes,
    @Default(<String, List<CartDecorationSelection>>{})
    Map<String, List<CartDecorationSelection>> decorationsByItem,
  }) = _CartState;
}

extension CartStateX on CartState {
  int get totalItems =>
      items.fold<int>(0, (total, item) => total + item.quantity);
}

class CartDecorationSelection {
  final int? decorationId;
  final int decorationTypeId;
  final String decorationTypeName;
  final String decorationTypeCode;
  final int? embOptionId;
  final int? embTypeId;
  final int? heatTransferTypeId;
  final double? heatTransferWidth;
  final double? heatTransferHeight;
  final int? screenPrintColorId;
  final int? screenPrintGarmentId;
  final int? screenPrintLocationId;
  final int? leatherColorId;
  final double? leatherWidth;
  final double? leatherHeight;
  final int? patchTypeId;
  final double? patchWidth;
  final double? patchHeight;
  final int? labelTypeId;
  final double? labelWidth;
  final double? labelHeight;
  final String? decorationImagePath;
  final Uint8List? decorationImageBytes;
  final String? decorationImageName;

  const CartDecorationSelection({
    this.decorationId,
    required this.decorationTypeId,
    required this.decorationTypeName,
    required this.decorationTypeCode,
    this.embOptionId,
    this.embTypeId,
    this.heatTransferTypeId,
    this.heatTransferWidth,
    this.heatTransferHeight,
    this.screenPrintColorId,
    this.screenPrintGarmentId,
    this.screenPrintLocationId,
    this.leatherColorId,
    this.leatherWidth,
    this.leatherHeight,
    this.patchTypeId,
    this.patchWidth,
    this.patchHeight,
    this.labelTypeId,
    this.labelWidth,
    this.labelHeight,
    this.decorationImagePath,
    this.decorationImageBytes,
    this.decorationImageName,
  });

  CartDecorationSelection copyWith({
    int? decorationId,
    int? decorationTypeId,
    String? decorationTypeName,
    String? decorationTypeCode,
    int? embOptionId,
    int? embTypeId,
    int? heatTransferTypeId,
    double? heatTransferWidth,
    double? heatTransferHeight,
    int? screenPrintColorId,
    int? screenPrintGarmentId,
    int? screenPrintLocationId,
    int? leatherColorId,
    double? leatherWidth,
    double? leatherHeight,
    int? patchTypeId,
    double? patchWidth,
    double? patchHeight,
    int? labelTypeId,
    double? labelWidth,
    double? labelHeight,
    String? decorationImagePath,
    Uint8List? decorationImageBytes,
    String? decorationImageName,
    bool clearDecorationImagePath = false,
    bool clearDecorationImageBytes = false,
  }) {
    return CartDecorationSelection(
      decorationId: decorationId ?? this.decorationId,
      decorationTypeId: decorationTypeId ?? this.decorationTypeId,
      decorationTypeName: decorationTypeName ?? this.decorationTypeName,
      decorationTypeCode: decorationTypeCode ?? this.decorationTypeCode,
      embOptionId: embOptionId ?? this.embOptionId,
      embTypeId: embTypeId ?? this.embTypeId,
      heatTransferTypeId: heatTransferTypeId ?? this.heatTransferTypeId,
      heatTransferWidth: heatTransferWidth ?? this.heatTransferWidth,
      heatTransferHeight: heatTransferHeight ?? this.heatTransferHeight,
      screenPrintColorId: screenPrintColorId ?? this.screenPrintColorId,
      screenPrintGarmentId: screenPrintGarmentId ?? this.screenPrintGarmentId,
      screenPrintLocationId:
          screenPrintLocationId ?? this.screenPrintLocationId,
      leatherColorId: leatherColorId ?? this.leatherColorId,
      leatherWidth: leatherWidth ?? this.leatherWidth,
      leatherHeight: leatherHeight ?? this.leatherHeight,
      patchTypeId: patchTypeId ?? this.patchTypeId,
      patchWidth: patchWidth ?? this.patchWidth,
      patchHeight: patchHeight ?? this.patchHeight,
      labelTypeId: labelTypeId ?? this.labelTypeId,
      labelWidth: labelWidth ?? this.labelWidth,
      labelHeight: labelHeight ?? this.labelHeight,
      decorationImagePath: clearDecorationImagePath
          ? null
          : (decorationImagePath ?? this.decorationImagePath),
      decorationImageBytes: clearDecorationImageBytes
          ? null
          : (decorationImageBytes ?? this.decorationImageBytes),
      decorationImageName: decorationImageName ?? this.decorationImageName,
    );
  }
}

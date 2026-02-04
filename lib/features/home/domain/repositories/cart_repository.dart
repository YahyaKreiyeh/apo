import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_entity.dart';

abstract class CartRepository {
  Future<ApiResponseModel<void>> addCartItem({
    required int variantId,
    required int quantity,
  });

  Future<ApiResponseModel<List<CartItemEntity>>> getCartItems();

  Future<ApiResponseModel<void>> deleteCartItem({required int cartItemId});

  Future<ApiResponseModel<void>> clearCart();

  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchDecorationTypeOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchHeatTransferTypeOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintColorOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintGarmentOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>>
  fetchScreenPrintLocationOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchLeatherColorOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchPatchTypeOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchLabelTypeOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchEmbOptions();

  Future<ApiResponseModel<List<MasterDetailEntity>>> fetchEmbTypes();
}

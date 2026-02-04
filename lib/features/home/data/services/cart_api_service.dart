import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/home/data/models/cart_item_dto.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
import 'package:apo/features/home/data/models/master_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CartApiService {
  factory CartApiService(Dio dio) = _CartApiService;

  @POST(ApiConstants.cartItems)
  Future<BaseApiResponse<void>> addCartItem(@Body() CartItemDto body);

  @GET(ApiConstants.cart)
  Future<BaseApiResponse<CartModel>> getCart();

  @DELETE('${ApiConstants.cartItems}/{id}')
  Future<BaseApiResponse<void>> deleteCartItem(@Path('id') int cartItemId);

  @DELETE(ApiConstants.cart)
  Future<BaseApiResponse<void>> clearCart();

  @GET(ApiConstants.decorationTypeDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchDecorationTypeDetails();

  @GET(ApiConstants.heatTransferTypeDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchHeatTransferTypeDetails();

  @GET(ApiConstants.screenPrintColorsDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchScreenPrintColorsDetails();

  @GET(ApiConstants.screenPrintGarmentDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchScreenPrintGarmentDetails();

  @GET(ApiConstants.screenPrintLocationDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchScreenPrintLocationDetails();

  @GET(ApiConstants.leatherColorDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>>
  fetchLeatherColorDetails();

  @GET(ApiConstants.patchTypeDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>> fetchPatchTypeDetails();

  @GET(ApiConstants.labelTypeDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>> fetchLabelTypeDetails();

  @GET(ApiConstants.embOptionsDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>> fetchEmbOptions();

  @GET(ApiConstants.embTypeDetails)
  Future<BaseApiResponse<List<MasterDetailModel>>> fetchEmbTypes();
}

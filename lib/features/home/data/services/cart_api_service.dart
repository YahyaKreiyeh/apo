import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/home/data/models/cart_item_dto.dart';
import 'package:apo/features/home/data/models/cart_model.dart';
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
}

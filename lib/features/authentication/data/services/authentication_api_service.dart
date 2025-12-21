import 'package:apo/core/models/base_api_response.dart';
import 'package:apo/core/networking/api_constants.dart';
import 'package:apo/features/authentication/data/models/login_dto.dart';
import 'package:apo/features/authentication/data/models/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthenticationApiService {
  factory AuthenticationApiService(Dio dio) = _AuthenticationApiService;

  @POST(ApiConstants.login)
  Future<BaseApiResponse<LoginResponseModel>> login(@Body() LoginDto body);
}

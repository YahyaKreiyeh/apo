import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/features/authentication/domain/models/login_entity.dart';
import 'package:apo/features/authentication/domain/models/login_parameters.dart';

abstract class AuthenticationRepository {
  Future<ApiResponseModel<LoginEntity>> login({
    required LoginParameters parameters,
  });
}

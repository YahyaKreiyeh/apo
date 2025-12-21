import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/features/authentication/domain/models/login_entity.dart';
import 'package:apo/features/authentication/domain/models/login_parameters.dart';
import 'package:apo/features/authentication/domain/repositories/authentication_repository.dart';

class LoginUseCase {
  final AuthenticationRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResponseModel<LoginEntity>> call(LoginParameters parameters) async {
    final response = await _repository.login(parameters: parameters);
    await response.whenOrNull(
      success: (data) async {
        await SecureStorageHelper.saveLoginTokens(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          accessTokenExpiresAt: data.accessTokenExpiresAt,
          refreshTokenExpiresAt: data.refreshTokenExpiresAt,
        );
      },
    );
    return response;
  }
}

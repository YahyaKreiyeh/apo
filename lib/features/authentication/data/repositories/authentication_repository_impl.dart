import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/authentication/data/mappers/login_response_mapper.dart';
import 'package:apo/features/authentication/data/models/login_dto.dart';
import 'package:apo/features/authentication/data/services/authentication_api_service.dart';
import 'package:apo/features/authentication/domain/models/login_entity.dart';
import 'package:apo/features/authentication/domain/models/login_parameters.dart';
import 'package:apo/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends BaseRepository
    implements AuthenticationRepository {
  final AuthenticationApiService _apiService;

  AuthenticationRepositoryImpl(this._apiService);

  @override
  Future<ApiResponseModel<LoginEntity>> login({
    required LoginParameters parameters,
  }) {
    return executeApiCall(
      apiCall: () => _apiService.login(
        LoginDto(
          email: parameters.email,
          password: parameters.password,
        ),
      ),
      mapper: (response) => response.data.toDomain(),
    );
  }
}

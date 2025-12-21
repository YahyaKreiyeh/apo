import 'package:apo/features/authentication/data/models/login_response_model.dart';
import 'package:apo/features/authentication/domain/models/login_entity.dart';

extension LoginResponseMapper on LoginResponseModel? {
  LoginEntity toDomain() {
    return LoginEntity(
      accessToken: this?.accessToken ?? '',
      accessTokenExpiresAt: this?.accessTokenExpiresAt ?? '',
      refreshToken: this?.refreshToken ?? '',
      refreshTokenExpiresAt: this?.refreshTokenExpiresAt ?? '',
      email: this?.email ?? '',
      firstName: this?.firstName ?? '',
      lastName: this?.lastName ?? '',
      userType: this?.userType ?? '',
      companyName: this?.companyName ?? '',
      roles: this?.roles.map((role) => role.toDomain()).toList() ?? const [],
      otp: '',
    );
  }
}

extension LoginRoleMapper on LoginRoleModel {
  LoginRoleEntity toDomain() {
    return LoginRoleEntity(
      roleId: roleId,
      roleName: roleName,
      roleCode: roleCode,
      roleType: roleType,
      description: description,
    );
  }
}

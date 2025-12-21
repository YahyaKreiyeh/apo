import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String accessToken;
  final String accessTokenExpiresAt;
  final String refreshToken;
  final String refreshTokenExpiresAt;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String companyName;
  final List<LoginRoleModel> roles;

  const LoginResponseModel({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.companyName,
    required this.roles,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class LoginRoleModel {
  final int roleId;
  final String roleName;
  final String roleCode;
  final String roleType;
  final String description;

  const LoginRoleModel({
    required this.roleId,
    required this.roleName,
    required this.roleCode,
    required this.roleType,
    required this.description,
  });

  factory LoginRoleModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRoleModelToJson(this);
}

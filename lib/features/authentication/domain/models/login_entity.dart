class LoginEntity {
  final String accessToken;
  final String accessTokenExpiresAt;
  final String refreshToken;
  final String refreshTokenExpiresAt;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String companyName;
  final List<LoginRoleEntity> roles;
  final String? otp;

  const LoginEntity({
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
    this.otp,
  });
}

class LoginRoleEntity {
  final int roleId;
  final String roleName;
  final String roleCode;
  final String roleType;
  final String description;

  const LoginRoleEntity({
    required this.roleId,
    required this.roleName,
    required this.roleCode,
    required this.roleType,
    required this.description,
  });
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      accessToken: json['accessToken'] as String,
      accessTokenExpiresAt: json['accessTokenExpiresAt'] as String,
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpiresAt: json['refreshTokenExpiresAt'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      userType: json['userType'] as String,
      companyName: json['companyName'] as String,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => LoginRoleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessTokenExpiresAt': instance.accessTokenExpiresAt,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpiresAt': instance.refreshTokenExpiresAt,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': instance.userType,
      'companyName': instance.companyName,
      'roles': instance.roles,
    };

LoginRoleModel _$LoginRoleModelFromJson(Map<String, dynamic> json) =>
    LoginRoleModel(
      roleId: (json['roleId'] as num).toInt(),
      roleName: json['roleName'] as String,
      roleCode: json['roleCode'] as String,
      roleType: json['roleType'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$LoginRoleModelToJson(LoginRoleModel instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'roleCode': instance.roleCode,
      'roleType': instance.roleType,
      'description': instance.description,
    };

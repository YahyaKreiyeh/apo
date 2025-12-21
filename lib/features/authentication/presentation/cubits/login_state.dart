import 'package:apo/core/models/result.dart';
import 'package:apo/features/authentication/domain/models/login_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(Result.empty()) Result<LoginEntity> status,
    @Default('') String email,
    @Default(null) String? emailError,
    @Default('') String password,
    @Default(null) String? passwordError,
    @Default(false) bool isPasswordVisible,
  }) = _LoginState;
}

extension LoginStateX on LoginState {
  bool get isEmailValid =>
      email.trim().isNotEmpty && (emailError == null || emailError!.isEmpty);

  bool get isPasswordValid =>
      password.trim().isNotEmpty &&
      (passwordError == null || passwordError!.isEmpty);
}

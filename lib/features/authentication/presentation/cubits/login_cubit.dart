import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/utilities/validators.dart';
import 'package:apo/features/authentication/domain/models/login_parameters.dart';
import 'package:apo/features/authentication/domain/usecases/login_usecase.dart';
import 'package:apo/features/authentication/presentation/cubits/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> with SafeEmitter<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginState());

  void onEmailChanged(String value) {
    safeEmit(
      state.copyWith(
        email: value,
        emailError: Validators.email(value),
      ),
    );
  }

  void onPasswordChanged(String value) {
    safeEmit(
      state.copyWith(
        password: value,
        passwordError: Validators.password(value),
      ),
    );
  }

  void togglePasswordVisibility() {
    safeEmit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  Future<void> login() async {
    safeEmit(state.copyWith(status: const Result.loading()));
    final response = await _loginUseCase(
      LoginParameters(
        email: state.email,
        password: state.password,
      ),
    );
    response.when(
      success: (data) =>
          safeEmit(state.copyWith(status: Result.success(data: data))),
      failure: (apiError) =>
          safeEmit(state.copyWith(status: Result.failure(error: apiError))),
    );
  }
}

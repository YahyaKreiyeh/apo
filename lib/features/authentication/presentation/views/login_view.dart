import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/app_toast.dart';
import 'package:apo/features/authentication/presentation/cubits/login_cubit.dart';
import 'package:apo/features/authentication/presentation/cubits/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final bool enableBackButton;
  const LoginView({super.key, this.enableBackButton = false});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status.isSuccess || current.status.isFailure),
      listener: (context, state) {
        state.status.whenOrNull(
          failure: (error, data) {
            AppToast.show(message: state.status.failureMessage);
          },
          success: (data) {
            AppToast.show(
              // message: LocaleKeys.verification_code_message.tr(),
              // TODO: remove on production
              message: 'success',
              type: AppToastType.success,
            );
          },
        );
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpace(200),
                    Text(AppStrings.signIn, style: TextStyles.text20500),
                    VerticalSpace(8),
                    Text(
                      AppStrings.enterYourEmailAndPasswordToAccessYourAccount,
                      style: TextStyles.text14400,
                    ),
                    _LoginForm(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(20),
        _EmailField(),
        VerticalSpace(20),
        _PasswordField(),
        VerticalSpace(20),
        _SigninButton(),
      ],
    );
  }
}

class _SigninButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginCubit c) => c.state.status.isLoading,
    );
    return ElevatedButton(
      onPressed: isLoading ? () {} : context.read<LoginCubit>().login,
      child: isLoading ? CircularProgressIndicator() : Text(AppStrings.signIn),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorText = context.select((LoginCubit c) => c.state.emailError);
    final isLoading = context.select(
      (LoginCubit c) => c.state.status.isLoading,
    );

    return TextField(
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
        LengthLimitingTextInputFormatter(254),
      ],
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: AppStrings.enterYourEmail,
        errorMaxLines: 5,
        errorText: errorText,
        prefixIcon: Icon(Icons.email_outlined),
      ),
      onChanged: context.read<LoginCubit>().onEmailChanged,
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final errorText = context.select((LoginCubit c) => c.state.passwordError);
    final isPasswordVisible = context.select(
      (LoginCubit c) => c.state.isPasswordVisible,
    );
    final isLoading = context.select(
      (LoginCubit c) => c.state.status.isLoading,
    );

    return TextField(
      enabled: !isLoading,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
        LengthLimitingTextInputFormatter(64),
      ],
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: AppStrings.enterYourPassword,
        errorMaxLines: 5,
        errorText: errorText,
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: GestureDetector(
          onTap: context.read<LoginCubit>().togglePasswordVisibility,
          child: Icon(
            isPasswordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
      onChanged: context.read<LoginCubit>().onPasswordChanged,
    );
  }
}

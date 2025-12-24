import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProfileCubit cubit) => cubit.state.isLoading,
    );
    final isAuthenticated = context.select(
      (ProfileCubit cubit) => cubit.state.isAuthenticated,
    );
    final isLoggingOut = context.select(
      (ProfileCubit cubit) => cubit.state.logoutStatus.isLoading,
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: isLoggingOut
                      ? () {}
                      : isAuthenticated
                      ? () => context.read<ProfileCubit>().logout()
                      : () => context.pushNamed(RouteNames.login.name),
                  child: Text(
                    isAuthenticated ? AppStrings.signOut : AppStrings.signIn,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/routing/routes.dart';
import 'package:apo/core/themes/theme.dart';
import 'package:apo/core/di/dependency_injection.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Apo extends StatelessWidget {
  const Apo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>.value(value: getIt<CartCubit>()),
        BlocProvider<ProfileCubit>.value(
          value: getIt<ProfileCubit>()..loadAuthStatus(),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.apollo,
        debugShowCheckedModeBanner: false,
        theme: getTheme(),
        routerConfig: router,
      ),
    );
  }
}

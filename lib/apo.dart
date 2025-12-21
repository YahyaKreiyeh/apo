import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/routing/routes.dart';
import 'package:apo/core/themes/theme.dart';
import 'package:flutter/material.dart';

class Apo extends StatelessWidget {
  const Apo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.apollo,
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      routerConfig: router,
    );
  }
}

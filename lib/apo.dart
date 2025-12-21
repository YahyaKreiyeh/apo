import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/routing/routes.dart';
import 'package:apo/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Apo extends StatefulWidget {
  final bool isAuthenticated;
  const Apo({super.key, required this.isAuthenticated});

  @override
  State<Apo> createState() => _ApoState();
}

class _ApoState extends State<Apo> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = constructRouter(isAuthenticated: widget.isAuthenticated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.apollo,
      debugShowCheckedModeBanner: false,
      theme: getTheme(),
      routerConfig: _router,
    );
  }
}

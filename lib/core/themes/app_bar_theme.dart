import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

AppBarTheme appBarTheme() => AppBarTheme(
  centerTitle: true,
  scrolledUnderElevation: 0,
  backgroundColor: AppColors.surface,
  foregroundColor: AppColors.onSurface,
  iconTheme: IconThemeData(color: AppColors.onSurface),
);

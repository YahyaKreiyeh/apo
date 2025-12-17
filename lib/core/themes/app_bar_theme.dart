import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

AppBarTheme appBarTheme() => AppBarTheme(
  centerTitle: false,
  scrolledUnderElevation: 0,
  backgroundColor: AppColors.surface,
  foregroundColor: AppColors.onSurface,
  titleTextStyle: TextStyles.text10500,
  iconTheme: IconThemeData(color: AppColors.onSurface),
);

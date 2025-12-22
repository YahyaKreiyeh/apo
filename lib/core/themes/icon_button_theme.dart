import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

IconButtonThemeData iconButtonThemeData() {
  return IconButtonThemeData(
    style: IconButton.styleFrom(
      backgroundColor: AppColors.secondaryContainer,
      foregroundColor: AppColors.primaryText,
    ),
  );
}

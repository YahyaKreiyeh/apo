import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme() => ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    minimumSize: const Size(double.infinity, ThemeConstants.buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ThemeConstants.buttonRadius),
    ),
    textStyle: TextStyles.text16500,
    // disabledBackgroundColor: AppColors.disabled,
    // disabledForegroundColor: AppColors.onPrimary,
    // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
  ),
);

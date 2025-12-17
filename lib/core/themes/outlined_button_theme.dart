import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

OutlinedButtonThemeData outlinedButtonTheme() => OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    minimumSize: const Size(double.infinity, ThemeConstants.buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ThemeConstants.buttonRadius),
      side: BorderSide(color: AppColors.outLine),
    ),
    textStyle: TextStyles.text16500,
    foregroundColor: AppColors.onSurface,
  ),
);

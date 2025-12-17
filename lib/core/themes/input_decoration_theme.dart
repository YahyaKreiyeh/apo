import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme() {
  final baseBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(ThemeConstants.inputFieldRadius),
    borderSide: BorderSide(color: AppColors.outLine),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(ThemeConstants.inputFieldRadius),
    borderSide: BorderSide(color: AppColors.error),
  );

  return InputDecorationTheme(
    filled: true,
    border: baseBorder,
    focusedBorder: baseBorder,
    enabledBorder: baseBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: errorBorder,
    hintStyle: TextStyles.text14400.copyWith(color: AppColors.hintText),
    errorStyle: TextStyles.text14400.copyWith(color: AppColors.error),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    suffixIconColor: AppColors.hintText,
  );
}

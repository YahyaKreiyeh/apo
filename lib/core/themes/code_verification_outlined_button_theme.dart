import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

ButtonStyle codeVerificationOutlinedButtonTheme() => OutlinedButton.styleFrom(
  backgroundColor: AppColors.secondaryContainer,
  minimumSize: Size.zero,
  padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ThemeConstants.buttonRadius),
  ),
);

import 'package:apo/core/themes/app_bar_theme.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/bottom_sheet_theme.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/dialog_theme.dart';
import 'package:apo/core/themes/divider_theme.dart';
import 'package:apo/core/themes/elevated_button_theme.dart';
import 'package:apo/core/themes/input_decoration_theme.dart';
import 'package:apo/core/themes/outlined_button_theme.dart';
import 'package:apo/core/themes/primary_text_theme.dart';
import 'package:apo/core/themes/progress_indicator_theme.dart';
import 'package:apo/core/themes/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData getTheme() {
  return ThemeData(
    dialogTheme: dialogTheme(),
    brightness: Brightness.light,
    colorScheme: colorScheme(),
    disabledColor: AppColors.disabled,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surface,
    hintColor: AppColors.hintText,
    dividerColor: AppColors.divider,
    textTheme: textTheme(),
    primaryTextTheme: primaryTextTheme(),
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
    dividerTheme: dividerTheme(),
    cardColor: AppColors.cardColor,
    bottomSheetTheme: bottomSheetTheme(),
    progressIndicatorTheme: progressIndicatorTheme(),
  );
}

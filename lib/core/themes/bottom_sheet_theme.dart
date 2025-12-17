import 'package:apo/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

BottomSheetThemeData bottomSheetTheme() => BottomSheetThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(ThemeConstants.dialogRadius),
    ),
  ),
);

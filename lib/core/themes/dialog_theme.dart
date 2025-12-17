import 'package:apo/core/constants/theme_constants.dart';
import 'package:flutter/material.dart';

DialogThemeData dialogTheme() => DialogThemeData(
  insetPadding: const EdgeInsets.symmetric(
    horizontal: ThemeConstants.dialogPadding,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ThemeConstants.dialogRadius),
  ),
);

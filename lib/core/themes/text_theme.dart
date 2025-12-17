import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

// Used by default (surface) widgets — text on your scaffold background, cards, dialogs, etc.
// It defines how text looks on background / surface colors (usually light backgrounds).
TextTheme textTheme() => ThemeData.light().textTheme.apply(
  displayColor: AppColors.onSurface,
  bodyColor: AppColors.onSurface,
);

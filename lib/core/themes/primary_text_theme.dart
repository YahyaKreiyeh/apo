import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

// Used by widgets that sit on primary-colored backgrounds, e.g. the AppBar, FloatingActionButton, or BottomAppBar.
// It ensures that text placed on top of your primary color remains legible (often white or light text).
TextTheme primaryTextTheme() => ThemeData.light().primaryTextTheme.apply(
  displayColor: AppColors.onPrimary,
  bodyColor: AppColors.onPrimary,
);

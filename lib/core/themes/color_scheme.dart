import 'package:apo/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

ColorScheme colorScheme() => const ColorScheme.light(
  // New
  // Primaries
  primary: AppColors.primary,
  primaryFixed: AppColors.primaryFixed,
  surface: AppColors.surface,
  secondaryFixed: AppColors.secondaryFixed,
  secondaryFixedDim: AppColors.secondaryFixedDim,
  surfaceDim: AppColors.surfaceDim,
  // Primaries Texts
  onPrimary: AppColors.onPrimary,
  onSurface: AppColors.onSurface,

  // Text
  secondary: AppColors.secondary,

  // Borders
  outline: AppColors.outLine,
  secondaryContainer: AppColors.secondaryContainer,

  // Old
  // Background
  // primaryContainer: AppColors.primaryContainer,
  // onPrimaryContainer: AppColors.onPrimaryContainer,
  // onSecondary: AppColors.onSecondary,
  // secondaryContainer: AppColors.secondaryContainer,
  // onSecondaryContainer: AppColors.onSecondaryContainer,
  // error: AppColors.error,
  // onError: AppColors.onError,
  // outlineVariant: AppColors.outlineVariant,
  // shadow: AppColors.shadow,
  // scrim: AppColors.overlay,
  // inverseSurface: AppColors.onSurface,
  // onInverseSurface: AppColors.surface,
  // inversePrimary: AppColors.primary,
  // surfaceTint: AppColors.primary,
  // primaryFixed: AppColors.primaryBackgroundColor,
  // secondaryFixed: AppColors.secondary400,
);

extension RestoColorScheme on ColorScheme {
  Color get shimmerBase => AppColors.shimmerBase;
  Color get shimmerHighlight => AppColors.shimmerHighlight;
  Color get secondaryText => AppColors.secondaryText;
  Color get hintText => AppColors.hintText;
  Color get grey => AppColors.grey;
}

import 'package:flutter/material.dart';
import 'app_semantic_colors.dart';

//! LIGHT SCHEME
final ColorScheme lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,

  // Primary action
  primary: AppSemanticColors.primaryActionLight,
  onPrimary: AppSemanticColors.onPrimaryActionLight,

  // Accent / highlight
  secondary: AppSemanticColors.accentLight,
  onSecondary: AppSemanticColors.textPrimaryLight,

  // Surfaces
  surface: AppSemanticColors.surfaceLight,
  onSurface: AppSemanticColors.textPrimaryLight,

  // Status
  error: Colors.red,
  onError: AppSemanticColors.onPrimaryActionLight,
);

//! DARK SCHEME
final ColorScheme darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,

  // Primary action
  primary: AppSemanticColors.primaryActionDark,
  onPrimary: AppSemanticColors.onPrimaryActionDark,

  // Accent / highlight
  secondary: AppSemanticColors.accentDark,
  onSecondary: AppSemanticColors.textPrimaryDark,

  // Surfaces
  surface: AppSemanticColors.surfaceDark,
  onSurface: AppSemanticColors.textPrimaryDark,

  // Status
  error: Colors.red,
  onError: AppSemanticColors.onPrimaryActionDark,
);

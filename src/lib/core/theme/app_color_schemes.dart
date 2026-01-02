import 'package:flutter/material.dart';
import 'app_semantic_colors.dart';

/// =====================
/// LIGHT COLOR SCHEME
/// =====================
final ColorScheme lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,

  // Active buttons
  primary: AppSemanticColors.primaryLight,
  onPrimary: AppSemanticColors.onPrimaryLight,

  // Accent (progress, hints)
  secondary: AppSemanticColors.accent,
  onSecondary: AppSemanticColors.textPrimaryLight,

  // Main surfaces (screens & cards)
  surface: AppSemanticColors.surfaceLight,
  onSurface: AppSemanticColors.textContentLight,

  // Status
  error: AppSemanticColors.error,
  onError: AppSemanticColors.onPrimaryLight,
);

/// =====================
/// DARK COLOR SCHEME
/// =====================
final ColorScheme darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,

  // Active buttons
  primary: AppSemanticColors.primaryDark,
  onPrimary: AppSemanticColors.onPrimaryDark,

  // Accent (progress, hints)
  secondary: AppSemanticColors.accent,
  onSecondary: AppSemanticColors.onPrimaryDark,

  // Main surfaces (screens & cards)
  surface: AppSemanticColors.surfaceDark,
  onSurface: AppSemanticColors.textContentDark,

  // Status
  error: AppSemanticColors.error,
  onError: AppSemanticColors.onPrimaryDark,
);

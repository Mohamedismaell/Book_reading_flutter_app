import 'package:flutter/material.dart';
import '../app_color_schemes.dart';
import '../app_semantic_colors.dart';
import '../app_text_theme.dart';

ThemeData getLightTheme() {
  final textTheme = AppTextTheme.from(lightColorScheme);
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppSemanticColors.backgroundLight,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppSemanticColors.surfaceMutedLight.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color_schemes.dart';
import '../app_semantic_colors.dart';
import '../app_text_theme.dart';

ThemeData getDarkTheme() {
  final textTheme = AppTextTheme.from(darkColorScheme);
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: AppSemanticColors.backgroundDark,
    //!input
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppSemanticColors.surfaceMutedDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      hintStyle: textTheme.bodySmall?.copyWith(
        color: darkColorScheme.onSurface,
      ),
    ),
    //!Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        // padding: EdgeInsets.symmetric(horizontal: 34, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
  );
}

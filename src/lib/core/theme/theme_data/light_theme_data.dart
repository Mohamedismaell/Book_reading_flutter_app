import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      fillColor: AppSemanticColors.surfaceMutedLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
      hintStyle: textTheme.bodySmall?.copyWith(
        color: lightColorScheme.onSurface,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
      ),
    ),
  );
}

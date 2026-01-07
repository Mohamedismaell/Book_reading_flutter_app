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
      fillColor: AppSemanticColors.surfaceMutedLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
      hintStyle: textTheme.bodySmall?.copyWith(
        color: darkColorScheme.onSurface,
      ),
    ),
    //!Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // rectangle
        ),
      ),
    ),
  );
}

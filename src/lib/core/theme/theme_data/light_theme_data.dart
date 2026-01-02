import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.eboneyClay,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

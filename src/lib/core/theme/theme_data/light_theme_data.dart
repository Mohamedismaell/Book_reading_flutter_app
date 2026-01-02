import 'package:flutter/material.dart';
import '../app_color_schemes.dart';
import '../app_text_theme.dart';

ThemeData getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: AppColors.eboneyClay,
    //     foregroundColor: Colors.white,
    //   ),
    // ),
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: AppTextTheme.from(lightColorScheme),
    scaffoldBackgroundColor: Colors.transparent, // gradient handles bg
  );
}

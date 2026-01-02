import 'package:flutter/material.dart';

import '../app_color_schemes.dart';
import '../app_text_theme.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: AppColors.darkBackground,
    // primaryColor: AppColors.primary,
    // textTheme: const TextTheme(
    //   bodyMedium: TextStyle(color: AppColors.darkText),
    // ),
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: AppTextTheme.from(darkColorScheme),
    scaffoldBackgroundColor: Colors.transparent,
  );
}

import 'package:flutter/material.dart';

class AppTextTheme {
  const AppTextTheme._();

  static const String font = 'Merriweather';

  static TextTheme from(ColorScheme c) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontFamily: font,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: c.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: font,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: c.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: font,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: c.onSurface,
      ),

      bodyLarge: TextStyle(
        fontFamily: font,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: c.onSurface.withOpacity(0.9),
      ),

      bodyMedium: TextStyle(
        fontFamily: font,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: c.onSurface.withOpacity(0.8),
      ),

      bodySmall: TextStyle(
        fontFamily: font,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: c.onSurface.withOpacity(0.6),
      ),

      labelLarge: TextStyle(
        fontFamily: font,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: c.onPrimary,
        letterSpacing: 0.4,
      ),
      labelMedium: TextStyle(
        fontFamily: font,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: c.onPrimary,
        letterSpacing: 0.4,
      ),
      labelSmall: TextStyle(
        fontFamily: font,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: c.onPrimary,
        letterSpacing: 0.4,
      ),
    );
  }
}

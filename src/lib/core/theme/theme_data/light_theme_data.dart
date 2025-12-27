import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData getLightTheme() {
  return ThemeData(
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         backgroundColor: AppColors.purplePrimary)),
    // navigationBarTheme: NavigationBarThemeData(
    //     backgroundColor: Colors.white,
    //     indicatorColor: Colors.transparent,
    //     iconTheme: WidgetStateProperty.resolveWith(
    //         (states) => IconThemeData(
    //             size: 28,
    //             color:
    //                 states.contains(WidgetState.selected)
    //                     ? AppColors.purplePrimary
    //                     : AppColors.greyPrimary)))
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.eboneyClay,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

// extension ShortTheme on BuildContext {
//   TextTheme get text => Theme.of(this).textTheme;
//   ColorScheme get colors => Theme.of(this).colorScheme;

// }

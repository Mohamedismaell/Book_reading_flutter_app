import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  const AppGradients._();

  static const LinearGradient brandBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [AppColors.ebonyClay, Color(0xFF4A5678)],
  );

  // Light
  static LinearGradient lightBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE6EEFF).withOpacity(0.9), Color(0xFFE6EEFF)],
  );

  // static const LinearGradient lightDialog = LinearGradient(
  //   colors: [AppColors.backGround, AppColors.backGround.withOpacity(0.8)],
  // );

  // Dark

  static const LinearGradient darkBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.gradient1, AppColors.gradient2],
  );
}

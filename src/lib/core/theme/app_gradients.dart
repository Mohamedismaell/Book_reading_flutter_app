import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:flutter/material.dart';

class AppGradients {
  const AppGradients._();

  static LinearGradient brand = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      AppSemanticColors.primaryActionLight,
      AppSemanticColors.primaryActionLight.withOpacity(0.6),
    ],
  );

  // Light
  // static LinearGradient lightBackground = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [Color(0xFFE6EEFF).withOpacity(0.9), Color(0xFFE6EEFF)],
  // );

  // static const LinearGradient lightDialog = LinearGradient(
  //   colors: [AppColors.backGround, AppColors.backGround.withOpacity(0.8)],
  // );

  // Dark

  // static const LinearGradient darkBackground = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [AppColors.gradient1, AppColors.gradient2],
  // );
}

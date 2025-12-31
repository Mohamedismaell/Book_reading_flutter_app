import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();
  static BoxShadow bannerSahdow = BoxShadow(
    color: AppColors.eboneyClay.withOpacity(0.4),
    // color: Color(0x662E3148),
    blurRadius: 20,
    spreadRadius: -5,
    offset: Offset(0, 0),
  );
  static BoxShadow containerSahdow = BoxShadow(
    // color: AppColors.eboneyClay.withOpacity(0.4),
    color: Color(0xff1F2687).withOpacity(0.07),
    blurRadius: 32,
    offset: Offset(0, 8),
  );
  static BoxShadow actionButton1 = BoxShadow(
    // color: AppColors.eboneyClay.withOpacity(0.4),
    color: AppColors.eboneyClay.withOpacity(0.3),
    blurRadius: 15,
    offset: Offset(0, 10),
    spreadRadius: -3,
  );
  static BoxShadow actionButton2 = BoxShadow(
    // color: AppColors.eboneyClay.withOpacity(0.4),
    color: AppColors.eboneyClay.withOpacity(0.3),
    offset: Offset(0, 4),
    blurRadius: 6,
    spreadRadius: -4,
  );
}

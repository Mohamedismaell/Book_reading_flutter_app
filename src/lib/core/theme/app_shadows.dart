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
  static BoxShadow ContainerSahdow = BoxShadow(
    // color: AppColors.eboneyClay.withOpacity(0.4),
    color: Color(0xff1F2687).withOpacity(0.07),
    blurRadius: 32,
    offset: Offset(0, 8),
  );
}

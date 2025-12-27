import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bookreading/core/theme/app_font_family.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle _textline(
    double size,
    FontWeight weight, {
    Color? color,
    double? height,
    double? letterSpacing,
  }) => TextStyle(
    fontSize: size,
    fontWeight: weight,
    fontFamily: AppFontFamily.merriweather,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  // Buttons
  static final TextStyle buttonSmall = _textline(
    10,
    FontWeight.w500,
    height: 1.5,
  );
  static final TextStyle buttonMedium = _textline(
    14,
    FontWeight.w500,
    height: 20 / 14,
    color: AppColors.slateGray,
  );
  static final TextStyle buttonMediumBold = _textline(
    14,
    FontWeight.w700,
    height: 20 / 14,
  );
  static final TextStyle buttonLargeBold = _textline(
    16,
    FontWeight.w700,
    height: 24 / 16,
  );

  // Headings
  static final TextStyle heading1 = _textline(
    24,
    FontWeight.w700,
    height: 30 / 24,
    letterSpacing: -0.6,
  );
  static final TextStyle heading1Small = _textline(
    18,
    FontWeight.w700,
    height: 28 / 18,
    letterSpacing: -0.45,
  );
  static final TextStyle heading1Medium = _textline(
    20,
    FontWeight.w700,
    height: 28 / 20,
    letterSpacing: -0.5,
  );
  static final TextStyle heading1Large = _textline(
    30,
    FontWeight.w700,
    height: 37.5 / 30,
    letterSpacing: -0.75,
  );

  static final TextStyle heading2 = _textline(
    20,
    FontWeight.w700,
    height: 28 / 20,
  );
  static final TextStyle heading2Upper = _textline(
    14,
    FontWeight.w700,
    height: 20 / 14,
    letterSpacing: 0.35,
  );

  static final TextStyle heading3 = _textline(
    18,
    FontWeight.w700,
    height: 28 / 18,
  );
  static final TextStyle heading3Upper = _textline(
    14,
    FontWeight.w700,
    height: 20 / 14,
    letterSpacing: 0.7,
  );

  // Inputs
  static final TextStyle input14 = _textline(
    14,
    FontWeight.w400,
    height: 20 / 14,
  );
  static final TextStyle input16 = _textline(
    16,
    FontWeight.w400,
    height: 24 / 16,
    color: AppColors.gullGray,
  );
  static final TextStyle input18 = _textline(
    18,
    FontWeight.w400,
    height: 24 / 16,
    color: Colors.black,
  );

  // Links
  static final TextStyle link = _textline(
    12,
    FontWeight.w400,
    height: 16 / 12,
    color: Colors.blue,
  );
}

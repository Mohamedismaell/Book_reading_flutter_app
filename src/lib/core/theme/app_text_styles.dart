import 'package:flutter/material.dart';
import 'package:bookreading/core/theme/app_font_family.dart';
// import 'app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle _textline(double size, FontWeight weight, {Color? color}) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: AppFontFamily.gotham,
        color: color,
      );

  // Bold (w700)
  static final text10Bold = _textline(10, FontWeight.w700);
  static final text12Bold = _textline(12, FontWeight.w700);
  static final text14Bold = _textline(14, FontWeight.w700);
  static final text16Bold = _textline(16, FontWeight.w700);
  static final text20Bold = _textline(20, FontWeight.w700);
  static final text24Bold = _textline(24, FontWeight.w700);
  static final text32Bold = _textline(32, FontWeight.w700);
  static final text36Bold = _textline(36, FontWeight.w700);
  static final text40Bold = _textline(40, FontWeight.w700);

  // Medium (w500)
  static final text10Medium = _textline(10, FontWeight.w500);
  static final text12Medium = _textline(12, FontWeight.w500);
  static final text14Medium = _textline(14, FontWeight.w500);
  static final text16Medium = _textline(16, FontWeight.w500);
  static final text20Medium = _textline(20, FontWeight.w500);
  static final text24Medium = _textline(24, FontWeight.w500);
  static final text32Medium = _textline(32, FontWeight.w500);
  static final text36Medium = _textline(36, FontWeight.w500);
  static final text40Medium = _textline(40, FontWeight.w500);

  // Regular (w400)
  static final text10 = _textline(10, FontWeight.w400);
  static final text12 = _textline(12, FontWeight.w400);
  static final text14 = _textline(14, FontWeight.w400);
  static final text16 = _textline(16, FontWeight.w400);
  static final text20 = _textline(20, FontWeight.w400);
  static final text24 = _textline(24, FontWeight.w400);
  static final text32 = _textline(32, FontWeight.w400);
  static final text36 = _textline(36, FontWeight.w400);
  static final text40 = _textline(40, FontWeight.w400);
}

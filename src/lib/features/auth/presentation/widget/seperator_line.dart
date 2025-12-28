import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SeperatorLine extends StatelessWidget {
  const SeperatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: 78.w,
            height: 3.h,
            decoration: BoxDecoration(color: AppColors.athensGray),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            "OR CONTINUE WITH",
            style: AppTextStyles.input16.copyWith(fontSize: 14),
          ),
        ),
        Flexible(
          child: Container(
            width: 78.w,
            height: 3.h,
            decoration: BoxDecoration(color: AppColors.athensGray),
          ),
        ),
      ],
    );
  }
}

import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            //Todo Fix Color
            decoration: BoxDecoration(
              color: AppSemanticColors.textSecondaryLight,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            "OR CONTINUE WITH",
            style: context.textTheme.bodySmall?.copyWith(fontSize: 13.sp),
          ),
        ),
        Flexible(
          child: Container(
            width: 78.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: AppSemanticColors.textSecondaryLight,
            ),
          ),
        ),
      ],
    );
  }
}

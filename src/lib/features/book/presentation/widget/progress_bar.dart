import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress, required this.width});

  final double width;
  final double progress;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: context.colorTheme.surface,
          ),
        ),
        Container(
          width: width * (progress / 100),
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: context.colorTheme.onSurface,
          ),
        ),
      ],
    );
  }
}

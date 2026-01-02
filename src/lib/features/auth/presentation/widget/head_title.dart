import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({super.key, required this.headText, required this.hashText});

  final String headText;
  final String hashText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(headText, style: context.textTheme.headlineLarge),
        SizedBox(height: 8.h),
        Text(hashText, style: context.textTheme.bodySmall),
      ],
    );
  }
}

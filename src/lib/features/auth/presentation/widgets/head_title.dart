import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({super.key, required this.headText, required this.hashText});

  final String headText;
  final String hashText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(headText, style: context.headlineLarge()),
        SizedBox(height: 8.h),
        Text(hashText, style: context.bodySmall()),
      ],
    );
  }
}

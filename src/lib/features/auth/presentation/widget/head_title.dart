import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({super.key, required this.headText, required this.hashText});

  final String headText;
  final String hashText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(headText, style: AppTextStyles.heading1.copyWith(fontSize: 32)),
        SizedBox(height: 8.h),
        Text(hashText, style: AppTextStyles.buttonMedium.copyWith()),
      ],
    );
  }
}

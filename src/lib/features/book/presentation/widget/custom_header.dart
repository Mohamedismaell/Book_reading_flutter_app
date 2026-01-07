import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, this.text});

  final String? text;
  @override
  Widget build(BuildContext context) {
    //Todo fix theme
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.arrow_back,
          size: 26.sp,
          color: context.colorTheme.onSurface,
        ),
        // Spacer(),
        Text(text ?? '', style: context.textTheme.headlineMedium),
        Icon(Icons.bookmark, size: 26.sp, color: context.colorTheme.primary),
      ],
    );
  }
}

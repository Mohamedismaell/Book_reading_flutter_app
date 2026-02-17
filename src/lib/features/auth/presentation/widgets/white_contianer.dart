import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class WhiteContianer extends StatelessWidget {
  const WhiteContianer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: context.colorTheme.surface,
        // boxShadow: [AppShadows.containerSahdow],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: child,
        ),
      ),
    );
  }
}

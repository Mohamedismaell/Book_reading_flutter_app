import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_gradients.dart';
// import '../../../../core/theme/app_shadows.dart';

class MainBanner extends StatelessWidget {
  const MainBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.brand,
        // boxShadow: [AppShadows.bannerSahdow],
        // borderRadius: BorderRadius.circular(context.setSp(16)),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
        child: SizedBox(
          width: 30.w,
          height: 36.h,
          child: SvgPicture.asset("assets/icons/logo.svg"),
        ),
      ),
    );
  }
}

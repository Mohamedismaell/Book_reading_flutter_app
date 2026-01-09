import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
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
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(16),
          vertical: context.setHeight(13),
        ),
        child: SizedBox(
          width: context.setWidth(30),
          height: context.setHeight(36),
          child: SvgPicture.asset("assets/icons/book_logo.svg"),
        ),
      ),
    );
  }
}

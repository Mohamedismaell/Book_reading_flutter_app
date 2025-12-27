import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';

class ActionAuthButton extends StatelessWidget {
  const ActionAuthButton({super.key, required this.myText});
  final String myText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppShadows.actionButton1, AppShadows.actionButton2],
      ),
      child: ElevatedButton(
        //******Todo trigger the onPressed with function later******
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                myText,
                style: AppTextStyles.buttonLargeBold.copyWith(fontSize: 18),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}

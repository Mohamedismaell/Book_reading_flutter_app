import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/signup_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(gradient: AppColors.backGround),
        decoration: BoxDecoration(color: AppColors.backGround),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SignUpCard(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextStyles.buttonMedium,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Log in",
                      style: AppTextStyles.buttonLargeBold.copyWith(
                        color: AppColors.eboneyClay,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

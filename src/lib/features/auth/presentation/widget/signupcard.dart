import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/app_shadows.dart';
import 'package:bookreading/core/theme/app_text_styles.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    //! Main White Container
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteContainer,
        boxShadow: [AppShadows.ContainerSahdow],
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: _Content(),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Banner
        _Banner(),
        SizedBox(height: 16.h),
        //! Titel
        _HeadTitle(),
        SizedBox(height: 32.h),
        //! Form
        Form(
          child: Column(
            children: [
              __SignUpFields(hintText: 'Full Name'),
              SizedBox(height: 16),
              __SignUpFields(hintText: 'Email Address'),
              SizedBox(height: 16),
              __SignUpFields(hintText: 'Password'),
            ],
          ),
        ),
        SizedBox(height: 32.h),
        AuthButton(myText: "Sign Up"),
        SizedBox(height: 24.h),
        Row(
          children: [
            Flexible(
              child: Container(
                width: 78.w,
                height: 1.h,
                decoration: BoxDecoration(color: AppColors.athensGray),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "OR CONTINUE WITH",
                style: AppTextStyles.input16.copyWith(fontSize: 14),
              ),
            ),
            Flexible(
              child: Container(
                width: 78.w,
                height: 1.h,
                decoration: BoxDecoration(color: AppColors.athensGray),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.brandBlue,
        boxShadow: [AppShadows.bannerSahdow],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        child: SvgPicture.asset("assets/icons/book_logo.svg"),
      ),
    );
  }
}

class _HeadTitle extends StatelessWidget {
  const _HeadTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Create Account",
          style: AppTextStyles.heading1.copyWith(fontSize: 32),
        ),
        SizedBox(height: 8.h),
        Text(
          "Start your reading journey today.",
          style: AppTextStyles.buttonMedium.copyWith(),
        ),
      ],
    );
  }
}

class __SignUpFields extends StatelessWidget {
  const __SignUpFields({required this.hintText});
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 18.h),
        hintText: hintText,
        hintStyle: AppTextStyles.input16,
      ),
      style: AppTextStyles.input18,
    );
  }
}

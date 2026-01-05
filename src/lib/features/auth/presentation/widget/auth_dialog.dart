import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/widget/action_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//Todo Adjust Text content in every dialog
class AuthDialog extends StatelessWidget {
  const AuthDialog({
    super.key,
    required this.title,
    required this.actionText,
    this.description,
  });
  final String title;
  final String? description;
  final String actionText;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: context.colorTheme.surface,
      backgroundColor: AppColors.nearBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: _Content(
        title: title,
        description: description ?? "",
        actionText: actionText,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.description,
    required this.actionText,
  });

  final String title;
  final String description;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CheckIcon(),
          SizedBox(height: 24.h),
          Text(title, style: context.textTheme.labelLarge),
          SizedBox(height: 8.h),
          Text(
            description,
            // "We’ve sent a verification link to your email address.\nPlease verify your email before logging in.",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: 24.h),
          ActionAuthButton(
            myText: actionText,
            onPressed: () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  const _CheckIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 90.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // gradient: LinearGradient(
        //   colors: [AppColors.backGround, AppColors.backGround.withOpacity(0.8)],
        // ),
        color: context.colorTheme.primary,
        boxShadow: [
          // BoxShadow(
          //   color: AppColors.backGround.withOpacity(0.3),
          //   blurRadius: 20.r,
          //   offset: const Offset(0, 8),
          // ),
        ],
      ),
      child: Icon(
        Icons.check_rounded,
        size: 48.sp,
        color: context.colorTheme.onPrimary,
      ),
    );
  }
}

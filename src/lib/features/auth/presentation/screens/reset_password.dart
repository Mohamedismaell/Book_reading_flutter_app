import 'package:bookreading/core/theme/app_gradients.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/widget/arrow_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../widget/reset_password_card.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: context.isLight
              ? AppGradients.lightBackground
              : AppGradients.darkBackground,
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ResetPasswordCard(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //! Arrow Back
            context.canPop() ? ArrowBack() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

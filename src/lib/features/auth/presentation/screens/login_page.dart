import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../widget/auth_redirect_prompt.dart';
import '../widget/login_card.dart';
import '../widget/theme_icon.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.backGround),
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
                          child: LoginCard(),
                        ),
                        AuthRedirectPrompt(
                          onPressed: () {
                            context.push(AppRoutes.signUp);
                          },
                          text: "Sign Up",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            ThemeIcon(),
          ],
        ),
      ),
    );
  }
}

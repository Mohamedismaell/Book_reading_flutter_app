import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/widget/arrow_back.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_redirect_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_gradients.dart';
import '../widget/signup_card.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    debugPrint('canPop: ${context.canPop()}');

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
                          child: SignUpCard(),
                        ),
                        AuthRedirectPrompt(
                          onPressed: () {
                            context.pushReplacement(AppRoutes.login);
                          },
                          text: "Log in",
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

import 'dart:ui';

import 'package:bookreading/core/enums/orb_position.dart';
import 'package:bookreading/core/theme/app_gradients.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../widget/auth_redirect_prompt.dart';
import '../widget/login_card.dart';
import '../../../../core/widget/theme_icon.dart';
import '../../../../core/widget/orb.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: context.isLight
              ? AppSemanticColors.backgroundLight
              : AppSemanticColors.backgroundDark,
        ),
        // AppColors.backGround
        child: Stack(
          children: [
            Orb(position: OrbPosition.topLeft),
            Orb(position: OrbPosition.centerRight, isCyan: false),
            Orb(position: OrbPosition.bottomLeft),
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

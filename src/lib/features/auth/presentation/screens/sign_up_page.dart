import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/features/auth/presentation/widgets/arrow_back.dart';
import 'package:bookreading/features/auth/presentation/widgets/auth_redirect_prompt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/orb_position.dart';
import '../../../../core/shared/routes/app_routes.dart';
import '../../../../core/widget/orb.dart';
import '../widgets/signup_card.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    debugPrint('canPop: ${context.canPop()}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Orb(position: OrbPosition.topRight, isCyan: false),
          Orb(position: OrbPosition.centerRight),
          Orb(position: OrbPosition.bottomLeft, isCyan: false),
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
    );
  }
}

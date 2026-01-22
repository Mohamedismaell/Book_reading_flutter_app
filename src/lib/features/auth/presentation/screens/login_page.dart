import 'package:bookreading/core/enums/orb_position.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/auth_redirect_prompt.dart';
import '../widgets/login_card.dart';
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
      body: Stack(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setWidth(16),
                        ),
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
    );
  }
}

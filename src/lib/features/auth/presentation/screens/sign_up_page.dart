import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/app_text_styles.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_redirect_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/login_email.dart';
import '../../domain/usecases/login_google.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/sign_up_email.dart';
import '../widget/signup_card.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        sl<LoginWithGoogle>(),
        sl<Logout>(),
        sl<SignUpWithEmail>(),
        sl<LoginWithEmail>(),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: AppColors.backGround),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SignUpCard(),
                ),
                AuthRedirectPrompt(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogInPage(),
                      ),
                    );
                  },
                  text: "Log in",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

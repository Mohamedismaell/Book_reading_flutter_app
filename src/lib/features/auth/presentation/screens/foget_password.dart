import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/arrow_back.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_redirect_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/usecases/forget_password.dart';
import '../../domain/usecases/login_email.dart';
import '../../domain/usecases/login_google.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/sign_up_email.dart';
import '../../domain/usecases/update_passwords.dart';
import '../widget/forget_password_card.dart';

class FogetPasswordPage extends StatelessWidget {
  const FogetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final minHeight =
        media.size.height - media.padding.top - media.padding.bottom;
    return BlocProvider(
      create: (context) => AuthCubit(
        sl<LoginWithGoogle>(),
        sl<Logout>(),
        sl<SignUpWithEmail>(),
        sl<LoginWithEmail>(),
        sl<ForgetPassword>(),
        sl<UpdatePassword>(),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: AppColors.backGround),
          child: Stack(
            children: [
              //! Arrow Back
              Navigator.canPop(context)
                  ? ArrowBack(onPressed: () => Navigator.pop(context))
                  : const SizedBox(),
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
                            //here chanfe
                            child: ForgetPasswordCard(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

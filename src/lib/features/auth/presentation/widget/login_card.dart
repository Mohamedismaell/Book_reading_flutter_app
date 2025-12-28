import 'package:bookreading/core/params/params.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/app_text_styles.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/action_auth_button.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widget/banner.dart';
import 'package:bookreading/features/auth/presentation/widget/error_message.dart';
import 'package:bookreading/features/auth/presentation/widget/google_button.dart';
import 'package:bookreading/features/auth/presentation/widget/head_title.dart';
import 'package:bookreading/features/auth/presentation/widget/seperator_line.dart';
import 'package:bookreading/features/auth/presentation/widget/white_contianer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/validation_type.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    //! Main White Container
    return WhiteContianer(child: _Content());
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Logo
        Logo(),
        SizedBox(height: 16.h),
        //! Title
        HeadTitle(
          headText: 'Welcome Back',
          hashText: 'Start your reading journey today.',
        ),
        SizedBox(height: 32.h),
        //! Form
        Form(
          key: _formKey,
          child: Column(
            children: [
              AuthInput(
                hintText: 'Email Address',
                validationType: ValidationType.email,
                onSaved: (value) => _email = value ?? '',
              ),
              SizedBox(height: 16),
              AuthInput(
                hintText: 'Password',
                validationType: ValidationType.password,
                onSaved: (value) => _password = value ?? '',
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        //! Error Message
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthError
                ? NoteMessage(
                    text: "Invalid email or password. Please try again.",
                  )
                : const SizedBox.shrink();
          },
        ),
        SizedBox(height: 8.h),
        //! Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              //TODO: Implement forgot password functionality
              print("Forgot Password pressed");
            },
            child: Text(
              "Forgot Password?",
              style: AppTextStyles.buttonMedium.copyWith(
                color: AppColors.eboneyClay,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        //! Action button
        ActionAuthButton(
          myText: "Log In",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<AuthCubit>().logInWithEmail(
                params: LoginParams(email: _email, password: _password),
              );
              _formKey.currentState!.reset();
            }
          },
        ),
        SizedBox(height: 24.h),
        //! hash Line
        SeperatorLine(),
        SizedBox(height: 12.h),
        //! Google Sign
        GoogleButton(
          onPressed: () {
            print("GoogleLogIn");
            context.read<AuthCubit>().logInWithGoogle();
          },
        ),
      ],
    );
  }
}

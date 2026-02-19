import 'package:bookreading/core/params/params.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widgets/action_auth_button.dart';
import 'package:bookreading/features/auth/presentation/widgets/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widgets/error_message.dart';
import 'package:bookreading/features/auth/presentation/widgets/google_button.dart';
import 'package:bookreading/features/auth/presentation/widgets/head_title.dart';
import 'package:bookreading/features/auth/presentation/widgets/main_banner.dart';
import 'package:bookreading/features/auth/presentation/widgets/seperator_line.dart';
import 'package:bookreading/features/auth/presentation/widgets/white_contianer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Banner
        MainBanner(),
        SizedBox(height: 24.h),
        //! Title
        HeadTitle(
          headText: 'Welcome Back',
          hashText: 'Start your reading journey today.',
        ),
        SizedBox(height: 40.h),
        //! Form
        _LoginForm(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
        SizedBox(height: 24.h),
        // //! Error Message
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthError
                ? NoteMessage(text: state.message)
                : const SizedBox.shrink();
          },
        ),
        //! Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              context.push(AppRoutes.forgotPassword);
            },
            child: Text(
              "Forgot Password?",
              style: context.textTheme.headlineSmall,
            ),
          ),
        ),
        SizedBox(height: 6.h),

        //! Action button
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            state is AuthSuccess ? _formKey.currentState!.reset() : null;
          },
          child: ActionAuthButton(
            myText: "Log In",

            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                context.read<AuthCubit>().logInWithEmail(
                  params: LoginParams(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: 24.h),
        // //! hash Line
        SeperatorLine(),
        SizedBox(height: 24.h),
        // //! Google Sign
        GoogleButton(
          onPressed: () {
            if (kDebugMode) {
              print("GoogleLogIn");
            }
            context.read<AuthCubit>().logInWithGoogle();
          },
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthInput(
            hintText: 'Email Address',
            validationType: ValidationType.email,
            onSaved: (value) => emailController.text = value ?? '',
            isPassword: false,
          ),
          SizedBox(height: 20.h),
          AuthInput(
            hintText: 'Password',
            validationType: ValidationType.password,
            onSaved: (value) => passwordController.text = value ?? '',
            isPassword: true,
          ),
        ],
      ),
    );
  }
}

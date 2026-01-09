import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/params/params.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/action_auth_button.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_dialog.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widget/main_banner.dart';
import 'package:bookreading/features/auth/presentation/widget/error_message.dart';
import 'package:bookreading/features/auth/presentation/widget/google_button.dart';
import 'package:bookreading/features/auth/presentation/widget/head_title.dart';
import 'package:bookreading/features/auth/presentation/widget/seperator_line.dart';
import 'package:bookreading/features/auth/presentation/widget/white_contianer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/validation_type.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({super.key});

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
        SizedBox(height: context.setHeight(16)),

        //! Titel
        HeadTitle(
          headText: 'Create Account',
          hashText: 'Start your reading journey today.',
        ),
        SizedBox(height: context.setHeight(32)),
        //! Form
        _SignUpForm(
          formKey: _formKey,
          nameController: _nameController,
          emailController: _emailController,
          passwordController: _passwordController,
        ),
        SizedBox(height: context.setHeight(4)),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthError
                ? NoteMessage(text: "This Email is already exists")
                : const SizedBox.shrink();
          },
        ),
        SizedBox(height: context.setHeight(32)),

        //! Action button
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthVerification) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AuthDialog(
                  title: "Password Reset",
                  description:
                      "We’ve sent a verification link to your email address.\nPlease verify your email before logging in.",
                  actionText: 'Log In',
                  onPressed: () => context.go(AppRoutes.login),
                ),
              );
            }
          },
          child: ActionAuthButton(
            myText: "Sign Up",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState!.save();
                context.read<AuthCubit>().signUpWithEmail(
                  params: SignupParams(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: context.setHeight(12)),
        //! hash Line
        SeperatorLine(),
        SizedBox(height: context.setHeight(12)),
        //! Google Sign
        GoogleButton(
          onPressed: () {
            print("GoogleSignUP");
            context.read<AuthCubit>().logInWithGoogle();
          },
        ),
      ],
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthInput(
            hintText: 'Full Name',
            validationType: ValidationType.fullName,
            controller: nameController,
            isPassword: false,
          ),
          SizedBox(height: context.setHeight(16)),
          AuthInput(
            hintText: 'Email Address',
            validationType: ValidationType.email,
            controller: emailController,
            isPassword: false,
          ),
          SizedBox(height: context.setHeight(16)),
          AuthInput(
            hintText: 'Password',
            validationType: ValidationType.password,
            controller: passwordController,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}

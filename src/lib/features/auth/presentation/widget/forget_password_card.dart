import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_dialog.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widget/main_banner.dart';
import 'package:bookreading/features/auth/presentation/widget/error_message.dart';
import 'package:bookreading/features/auth/presentation/widget/head_title.dart';
import 'package:bookreading/features/auth/presentation/widget/white_contianer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/validation_type.dart';
import '../../../../core/params/params.dart';
import 'action_auth_button.dart';

class ForgetPasswordCard extends StatelessWidget {
  const ForgetPasswordCard({super.key});

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

  @override
  void dispose() {
    _emailController.dispose();
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
        HeadTitle(headText: 'Change Password', hashText: ''),
        SizedBox(height: context.setHeight(10)),
        //! Form
        _ForgetForm(formKey: _formKey, emailController: _emailController),
        SizedBox(height: context.setHeight(4)),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return state is AuthError
                ? NoteMessage(text: "This Email doesn't exists")
                : const SizedBox.shrink();
          },
        ),
        SizedBox(height: context.setHeight(20)),
        //! Action button
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthForgetPassword) {
              showDialog(
                context: context,
                builder: (context) => AuthDialog(
                  title: "Reset Link Sent",
                  description: "Check your inbox for the password reset link.",
                  actionText: 'Continue',
                  onPressed: () => context.pop(),
                ),
              );
            }
          },
          child: ActionAuthButton(
            myText: "Send Request",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState!.save();
                context.read<AuthCubit>().requestResetPassword(
                  params: ForgotPasswordParams(email: _emailController.text),
                );
                _formKey.currentState!.reset();
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ForgetForm extends StatelessWidget {
  const _ForgetForm({required this.formKey, required this.emailController});
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
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
        ],
      ),
    );
  }
}

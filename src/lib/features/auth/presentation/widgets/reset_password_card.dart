import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widgets/auth_dialog.dart';
import 'package:bookreading/features/auth/presentation/widgets/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widgets/main_banner.dart';
import 'package:bookreading/features/auth/presentation/widgets/head_title.dart';
import 'package:bookreading/features/auth/presentation/widgets/white_contianer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/validation_type.dart';
import 'action_auth_button.dart';

class ResetPasswordCard extends StatelessWidget {
  const ResetPasswordCard({super.key});

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
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return _ResetForm(
              formKey: _formKey,
              newPasswordController: _newPasswordController,
              confirmPasswordController: _confirmPasswordController,
            );
          },
        ),
        SizedBox(height: context.setHeight(20)),

        //! Action button
        _OnSubmit(
          formKey: _formKey,
          newPasswordController: _newPasswordController,
          confirmPasswordController: _confirmPasswordController,
        ),
      ],
    );
  }
}

class _ResetForm extends StatelessWidget {
  const _ResetForm({
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });
  final GlobalKey<FormState> formKey;

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AuthInput(
            isPassword: true,
            validationType: ValidationType.password,
            hintText: 'New Password',
            controller: newPasswordController,
          ),
          SizedBox(height: context.setHeight(10)),
          AuthInput(
            hintText: 'Confirm Password',
            controller: confirmPasswordController,
            isPassword: true,
            validationType: ValidationType.password,
            validator: (value) => value != newPasswordController.text
                ? 'Passwords must match'
                : null,
          ),
        ],
      ),
    );
  }
}

class _OnSubmit extends StatelessWidget {
  const _OnSubmit({
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUpdatePassword) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AuthDialog(
              title: "Password Changed Successfully",
              actionText: 'Log In',
              onPressed: () => context.pop(),
            ),
          );
        }
      },
      child: ActionAuthButton(
        myText: "Send Request",
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            formKey.currentState!.save();
            context.read<AuthCubit>().resetePassword(
              newPassword: confirmPasswordController.text,
            );
            formKey.currentState!.reset();
            context.go(AppRoutes.login);
          }
        },
      ),
    );
  }
}

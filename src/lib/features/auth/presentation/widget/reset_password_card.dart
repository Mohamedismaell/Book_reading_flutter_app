import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/widget/auth_input.dart';
import 'package:bookreading/features/auth/presentation/widget/banner.dart';
import 'package:bookreading/features/auth/presentation/widget/head_title.dart';
import 'package:bookreading/features/auth/presentation/widget/white_contianer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String _newPassword = '';

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Logo
        Logo(),
        SizedBox(height: 16.h),
        //! Titel
        HeadTitle(headText: 'Change Password', hashText: ''),
        SizedBox(height: 10.h),
        //! Form
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthInput(
                    isPassword: true,
                    validationType: ValidationType.password,
                    hintText: 'New Password',
                    onSaved: (value) => _newPassword = value ?? '',
                    controller: _newPasswordController,
                  ),
                  SizedBox(height: 10.h),
                  AuthInput(
                    isPassword: true,
                    validationType: ValidationType.password,
                    hintText: 'Confirm Password',
                    // onSaved: (value) => _confirmPassword = value ?? '',
                    validator: (value) => value != _newPasswordController.text
                        ? 'Passwords must match'
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
        //! Action button
        ActionAuthButton(
          myText: "Send Request",
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState!.save();
              context.read<AuthCubit>().resetePassword(
                newPassword: _newPassword,
              );
              _formKey.currentState!.reset();
            }
          },
        ),
      ],
    );
  }
}

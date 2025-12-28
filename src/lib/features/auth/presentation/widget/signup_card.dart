import 'package:bookreading/core/params/params.dart';
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

  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Logo
        Logo(),
        SizedBox(height: 16.h),

        //! Titel
        HeadTitle(
          headText: 'Create Account',
          hashText: 'Start your reading journey today.',
        ),
        SizedBox(height: 32.h),
        //! Form
        Form(
          key: _formKey,
          child: Column(
            children: [
              AuthInput(
                hintText: 'Full Name',
                validationType: ValidationType.fullName,
                onSaved: (value) => _name = value ?? '',
              ),
              SizedBox(height: 16),
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
        ErrorMessage(text: "This Email is already exists"),
        SizedBox(height: 32.h),
        //! Action button
        ActionAuthButton(
          myText: "Sign Up",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              context.read<AuthCubit>().signUpWithEmail(
                params: SignupParams(
                  name: _name,
                  email: _email,
                  password: _password,
                ),
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
            print("GoogleSignUP");
            context.read<AuthCubit>().logInWithGoogle();
          },
        ),
      ],
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit/auth_cubit.dart';

class ActionAuthButton extends StatelessWidget {
  const ActionAuthButton({
    super.key,
    required this.myText,
    required this.onPressed,
    // required this.state,
  });
  final String myText;
  final Function() onPressed;
  // final AuthState state;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: _Content(state: state, myText: myText, isLoading: isLoading),
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.state,
    required this.myText,
    required this.isLoading,
  });
  final AuthState state;
  final String myText;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoading ? "Please wait..." : myText,
          style: context.labelLarge(),
        ),
        SizedBox(width: 8.w),
        isLoading ? CircularProgressIndicator() : Icon(Icons.arrow_forward),
      ],
    );
  }
}

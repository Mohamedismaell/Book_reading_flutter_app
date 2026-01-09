import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
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
            padding: EdgeInsets.symmetric(vertical: context.setHeight(16)),
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
        SizedBox(width: context.setWidth(8)),
        isLoading ? CircularProgressIndicator() : Icon(Icons.arrow_forward),
      ],
    );
  }
}

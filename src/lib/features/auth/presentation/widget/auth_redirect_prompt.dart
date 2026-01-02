import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class AuthRedirectPrompt extends StatelessWidget {
  const AuthRedirectPrompt({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?", style: context.textTheme.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(text, style: context.textTheme.headlineSmall),
        ),
      ],
    );
  }
}

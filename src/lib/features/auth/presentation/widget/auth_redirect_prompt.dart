import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

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
        Text("Already have an account?", style: AppTextStyles.buttonMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: AppTextStyles.buttonLargeBold.copyWith(
              color: AppColors.eboneyClay,
            ),
          ),
        ),
      ],
    );
  }
}

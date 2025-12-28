import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../cubit/cubit/auth_cubit.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state is AuthError
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}

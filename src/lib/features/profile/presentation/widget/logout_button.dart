import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthCubit>().logout();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorTheme.primary.withOpacity(0.05),
        foregroundColor: context.colorTheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.w,
        children: [Icon(Icons.logout), Text('Log Out')],
      ),
    );
  }
}

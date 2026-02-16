import 'package:bookreading/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.read<AppGateCubit>().start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/logo-icon.svg', width: 48.w),
            SizedBox(height: 24.h),
            Text(
              'QuickRead',
              style: context.textTheme.headlineLarge!.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // SvgPicture.asset(
            //   'assets/images/logo-text.svg',
            //   width: 120.w,
            // ),
          ],
        ),
      ),
    );
  }
}

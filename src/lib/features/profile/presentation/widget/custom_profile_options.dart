import 'package:bookreading/core/enums/profile.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileOptions extends StatelessWidget {
  const CustomProfileOptions({
    super.key,
    this.onTap,
    this.leadingText,
    required this.widgetType,
  });
  final GestureTapCallback? onTap;
  final Widget? leadingText;
  final Profile widgetType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: context.colorTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: _buildLeading(context, widgetType),
          ),
          title: Text(
            widgetType.value,
            style: context.textTheme.labelLarge!.copyWith(
              color: AppColors.gray,
            ),
          ),

          trailing: _buildTrailing(context, widgetType),
        ),
      ),
    );
  }
}

Widget _buildLeading(BuildContext context, Profile widgetType) {
  switch (widgetType) {
    case Profile.appTheme:
      return Icon(Icons.dark_mode, color: context.colorTheme.primary);
    case Profile.accountSecurity:
      return Icon(Icons.security, color: context.colorTheme.primary);
    case Profile.language:
      return Icon(Icons.language, color: context.colorTheme.primary);
  }
}

Widget _buildTrailing(BuildContext context, Profile widgetType) {
  switch (widgetType) {
    case Profile.appTheme:
      return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Switch(
            value: state.isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().toggleTheme();
            },
          );
        },
      );
    default:
      return Icon(Icons.arrow_forward_ios, size: 24.sp);
  }
}

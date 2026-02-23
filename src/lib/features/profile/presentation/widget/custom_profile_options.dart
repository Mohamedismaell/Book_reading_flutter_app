import 'package:bookreading/core/enums/profile.dart';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
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
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          leading: Text(
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

Widget _buildTrailing(BuildContext context, Profile widgetType) {
  switch (widgetType) {
    case Profile.notifications:
      return Switch(value: true, onChanged: (value) {});
    case Profile.signOut:
      return Icon(Icons.logout, size: 24.sp);
    default:
      return Icon(Icons.arrow_forward_ios, size: 24.sp);
  }
}

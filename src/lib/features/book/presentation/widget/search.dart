import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 25.sp,
          color: context.colorTheme.onSurface.withOpacity(0.5),
        ),

        prefixIconConstraints: BoxConstraints(minWidth: 60.w, minHeight: 25.h),
        hintText: "Search ",
        hintStyle: context.textTheme.bodyMedium,
        contentPadding: EdgeInsets.symmetric(vertical: 9.h),
      ),
    );
  }
}

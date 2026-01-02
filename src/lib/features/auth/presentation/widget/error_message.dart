import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteMessage extends StatelessWidget {
  const NoteMessage({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: context.textTheme.bodySmall!.copyWith(
            color: context.colorTheme.error,
          ),
        ),
      ),
    );
  }
}

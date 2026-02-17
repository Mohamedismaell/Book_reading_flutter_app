import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class BookOverview extends StatelessWidget {
  const BookOverview({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.headlineMedium()),
          SizedBox(height: 10.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium().copyWith(fontSize: 18.sp),
            ),
          ),

          Center(
            child: TextButton.icon(
              onPressed: () {
                _showReadMoreDialog(
                  context,
                  title: title,
                  description: description,
                );
              },
              label: Text(
                "Read More",
                style: context.labelLarge().copyWith(
                  color: AppSemanticColors.primaryActionDark,
                ),
              ),
              iconAlignment: IconAlignment.end,
              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 25.r),
            ),
          ),
        ],
      ),
    );
  }
}

void _showReadMoreDialog(
  BuildContext context, {
  required String title,
  required String description,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Read more",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (_, _, _) {
      return _ReadMore(title: title, description: description);
    },

    transitionBuilder: (_, animation, _, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.94,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}

class _ReadMore extends StatelessWidget {
  const _ReadMore({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.45)),
            ),
          ),
        ),

        Center(
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxHeight: 500),
              decoration: BoxDecoration(
                color: context.colorTheme.surfaceContainer,
                // color: Colors.transparent,
                borderRadius: BorderRadius.circular(24.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 30.r, horizontal: 16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.headlineMedium()),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Text(
                      description,
                      style: context.bodyMedium().copyWith(fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';

import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Expanded(
      child: Container(
        // height: 270.h,
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.all(18.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  description,
                  // softWrap: true,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                _showReadMoreDialog(
                  context,
                  title: title,
                  description: description,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Read More",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: context.colorTheme.primary,
                    ),
                  ),
                  // iconAlignment: IconAlignment.end,
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24.sp,
                    color: context.colorTheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
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
              // constraints: BoxConstraints(maxHeight: 500.h),
              decoration: BoxDecoration(
                color: context.colorTheme.surfaceContainer,
                // color: Colors.transparent,
                borderRadius: BorderRadius.circular(24.r),
              ),
              padding: EdgeInsets.all(18.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textTheme.headlineMedium),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Text(
                      description,
                      style: context.textTheme.bodyMedium,
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

import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Continue Reading",
                style: context.textTheme.headlineSmall,
              ),
            ),
            Text("See All", style: context.textTheme.bodySmall),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Book
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.antiAlias,
              width: 120.w,
              height: 200.h,
              child: Image.asset(
                'assets/images/back_ground_auth.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: SizedBox(height: 200.h, child: _BookDetails()),
            ),
          ],
        ),
      ],
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Book Type", style: context.textTheme.bodyMedium),
            SizedBox(height: 5.h),
            Text("Book Title", style: context.textTheme.headlineSmall),
            SizedBox(height: 5.h),
            Text("Book Author", style: context.textTheme.bodyMedium),
            // Align(alignment: AlignmentGeometry.centerRight, child: Text("Icon")),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorTheme.onSurface,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_arrow_outlined,
                    color: context.colorTheme.surface,
                  ),
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Chapter 4",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      "45%",
                      style: context.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ProgressBar(progress: 45, width: 210.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

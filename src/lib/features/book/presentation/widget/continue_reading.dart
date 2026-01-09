import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = screenHeight < 700 ? 250.0 : 500.0;
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
        SizedBox(
          height: cardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Book
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                clipBehavior: Clip.antiAlias,
                width: 160.w,
                height: 250.w,
                child: Image.asset(
                  'assets/images/back_ground_auth.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.w),
              // Expanded(child: _BookDetails()),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      // height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Book Type", style: context.textTheme.bodyMedium),
          SizedBox(height: 5.h),
          Text("Book Title", style: context.textTheme.headlineSmall),
          SizedBox(height: 5.h),
          Expanded(
            child: Text("Book Author", style: context.textTheme.bodyMedium),
          ),
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
              LayoutBuilder(
                builder: (context, constraints) {
                  return ProgressBar(progress: 45, width: constraints.maxWidth);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackFinishedBooks extends StatelessWidget {
  const TrackFinishedBooks({super.key, required this.state});
  final LibraryState state;
  @override
  Widget build(BuildContext context) {
    final numFinishedBooks = state.finishedBooks.length;
    return SliverToBoxAdapter(
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: context.colorTheme.surfaceContainer,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Reading Stats', style: context.textTheme.bodyLarge),

                  // SizedBox(height: 4.h),
                  Text(
                    '$numFinishedBooks books',
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: AppSemanticColors.primaryActionLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 2.h),
                  Text('Reading Stats', style: context.textTheme.bodyLarge),
                ],
              ),
              Spacer(),

              Container(
                width: 48.w,
                height: 48.h,

                decoration: BoxDecoration(
                  color: context.colorTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: context.colorTheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

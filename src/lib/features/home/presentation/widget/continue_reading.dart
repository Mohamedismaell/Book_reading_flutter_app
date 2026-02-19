import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/home/presentation/widget/card_Item.dart';
import 'package:bookreading/features/progress/presentation/manager/reading_pregress/reading_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Continue Reading", style: context.textTheme.headlineMedium),
        SizedBox(height: 16.h),
        Container(
          // width: 350.w,
          height: 310.h,
          decoration: BoxDecoration(
            // color: context.colorTheme.surfaceContainer,
            color: Color(0xFF27272A).withOpacity(0.1),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: BlocBuilder<ReadingProgressCubit, ReadingProgressState>(
              builder: (context, state) {
                return _buildBookStateUI(context, state);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookStateUI(BuildContext context, ReadingProgressState state) {
    if (state.progressStatus == LoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.progressStatus == LoadStatus.error) {
      return Center(child: Text('Something went wrong ${state.message ?? ''}'));
    }

    if (state.progressStatus == LoadStatus.loaded) {
      final isContinue = state.progress != null;
      if (isContinue) {
        final progress = state.progress!;
        return CardItem(
          book: progress.bookDetails!,
          chapter: progress.chapterDetails!,
          progress: progress,
        );
      } else {
        return const Center(child: Text('Start Reading Books'));
      }
    }

    return const SizedBox.shrink();
  }
}

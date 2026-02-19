import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book/data/models/chapter_model.dart';
import 'package:bookreading/features/home/presentation/widget/progress_bar.dart';
import 'package:bookreading/features/home/presentation/manager/home/home_cubit.dart';
import 'package:bookreading/features/progress/data/models/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getProgress();

    return Container(
      width: 350.w,
      height: 310.h,
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return _buildBookStateUI(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBookStateUI(BuildContext context, HomeState state) {
    return switch (state.progressStatus) {
      LoadStatus.loading => const Center(child: CircularProgressIndicator()),
      LoadStatus.error => Center(
        child: Text('Something went wrong ${state.progressErrorMessage}'),
      ),
      LoadStatus.loaded => _buildCardItem(
        context,
        state.progress!.bookDetails!,
        state.progress!.chapterDetails!,
        state.progress!,
        () {
          context.pushNamed(
            'bookDetails',
            pathParameters: {
              'bookId': state.progress!.bookDetails!.id.toString(),
            },
            extra: {
              'heroTag': 'continue_${state.progress!.bookDetails!.id}',
              'coverUrl': state.progress!.bookDetails!.coverUrl,
              'title': state.progress!.bookDetails!.title,
              'author': state.progress!.bookDetails!.author,
            },
          );
        },
      ),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildCardItem(
    BuildContext context,
    BookModel book,
    ChapterModel chapter,
    ProgressModel progress,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        _buildBookCover(context, book, onTap),
        SizedBox(width: 20.w),
        _buildBookInfo(context, book, chapter, progress),
      ],
    );
  }

  Widget _buildBookCover(
    BuildContext context,
    BookModel book,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16.r),

        child: SizedBox(
          width: 160.w,
          height: double.infinity,
          child: Hero(
            tag: 'continue_${book.id}',
            child: Image.network(book.coverUrl!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _buildBookInfo(
    BuildContext context,
    BookModel book,
    ChapterModel chapter,
    ProgressModel progress,
  ) {
    final lastRead = DateTime.now().difference(progress.updatedAt);
    String formatTime(Duration duration) {
      if (duration.inMinutes < 1) return 'Just now';
      if (duration.inHours < 1) return '${duration.inMinutes}m ago';
      if (duration.inDays < 1) return '${duration.inHours}h ago';
      if (duration.inDays < 30) return '${duration.inDays}d ago';
      if (duration.inDays < 365) return '${duration.inDays ~/ 30}mo ago';
      return '${duration.inDays ~/ 365}y ago';
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, maxLines: 2, style: context.headlineSmall()),
            SizedBox(height: 12.h),
            Text(book.author!, style: context.bodyLarge()),
            SizedBox(height: 12.h),
            Text(chapter.title, style: context.bodyLarge()),
            SizedBox(height: 12.h),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Last Read: ', style: context.bodyMedium()),
                  TextSpan(
                    text: formatTime(lastRead),
                    style: context.bodyMedium().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(child: _buildBookProgress(context, chapter, progress)),
          ],
        ),
      ),
    );
  }

  Widget _buildBookProgress(
    BuildContext context,
    ChapterModel chapter,
    ProgressModel progress,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   child: Text(
            //     "Chapter ${chapter.chapterIndex}",
            //     style: context.bodyMedium(),
            //   ),
            // ),
            // SizedBox(width: 6.w),
            Expanded(
              child: Text(
                "${(progress.percentage * 100).toInt()}%",
                style: context.bodySmall().copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorTheme.surface,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow_outlined,
                  size: 24.r,
                  color: context.colorTheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ProgressBar(progress: progress.percentage),
      ],
    );
  }
}

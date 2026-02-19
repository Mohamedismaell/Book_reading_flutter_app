import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book/data/models/chapter_model.dart';
import 'package:bookreading/features/home/presentation/widget/progress_bar.dart';
import 'package:bookreading/features/progress/data/models/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.book,
    required this.chapter,
    required this.progress,
  });
  final BookModel book;
  final ChapterModel chapter;
  final ProgressModel progress;
  @override
  Widget build(BuildContext context) {
    final lastRead = DateTime.now().difference(progress.updatedAt);
    String formatTime(Duration duration) {
      if (duration.inMinutes < 1) return 'Just now';
      if (duration.inHours < 1) return '${duration.inMinutes}m ago';
      if (duration.inDays < 1) return '${duration.inHours}h ago';
      if (duration.inDays < 30) return '${duration.inDays}d ago';
      if (duration.inDays < 365) return '${duration.inDays ~/ 30}mo ago';
      return '${duration.inDays ~/ 365}y ago';
    }

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              'bookDetails',
              pathParameters: {'bookId': progress.bookDetails!.id.toString()},
              extra: {
                'heroTag': 'continue_${progress.bookDetails!.id}',
                'coverUrl': progress.bookDetails!.coverUrl,
                'title': progress.bookDetails!.title,
                'author': progress.bookDetails!.author,
              },
            );
          },
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(16.r),

            child: SizedBox(
              height: double.infinity,
              child: Hero(
                tag: 'continue_${book.id}',
                child: Image.network(book.coverUrl!, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  style: context.textTheme.bodyMedium,
                ),
                Text(book.author!, style: context.textTheme.bodyMedium),
                SizedBox(height: 12.h),
                Text(chapter.title, style: context.textTheme.bodyMedium),
                SizedBox(height: 12.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Last Read: ',
                        style: context.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: formatTime(lastRead),
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "${(progress.percentage * 100).toInt()}%",
                              style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {},
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorTheme.surface,
                              ),
                              child: Icon(
                                Icons.play_arrow_outlined,
                                size: 20.sp,
                                color: context.colorTheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ProgressBar(progress: progress.percentage),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

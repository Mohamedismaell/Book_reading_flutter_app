import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/data/models/user_progress.dart';
import 'package:bookreading/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContinueReading extends StatefulWidget {
  const ContinueReading({super.key});

  @override
  State<ContinueReading> createState() => _ContinueReadingState();
}

class _ContinueReadingState extends State<ContinueReading> {
  @override
  void initState() {
    context.read<ReadingProgressCubit>().loadProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(350, 310),
      width: context.setWidth(350),
      height: context.setHeight(310),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeProvider.width,
            height: context.sizeProvider.height,
            decoration: BoxDecoration(
              color: context.colorTheme.surfaceContainer,
              // shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(context.setMinSize(24)),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.setMinSize(16)),
              child: BlocBuilder<ReadingProgressCubit, ReadingProgressState>(
                builder: (context, state) => _buildBookStateUI(context, state),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildBookStateUI(BuildContext context, ReadingProgressState state) {
  return switch (state) {
    ReadingProgressLoading() || ReadingProgressInitial() => const Center(
      child: CircularProgressIndicator(),
    ),
    ReadingProgressError(:final message) => Center(child: Text(message)),
    ReadingProgressLoaded(:final progress) => _buildCardItem(
      context,
      progress.bookDetails!,
      progress.chapterDetails!,
      progress,
    ),
    _ => const SizedBox.shrink(),
  };
}

Widget _buildCardItem(
  BuildContext context,
  BookModel book,
  ChapterModel chapter,
  UserProgressModel progress,
) {
  return Row(
    children: [
      _buildBookCover(context),
      SizedBox(width: context.setMinSize(20)),
      _buildBookInfo(context, book, chapter, progress),
    ],
  );
}

Widget _buildBookCover(BuildContext context) {
  return ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(context.setMinSize(16)),

    child: SizedBox(
      width: context.sizeProvider.width / 2.3,
      height: double.infinity,
      child: Image.asset(
        "assets/images/back_ground_auth.jpg",
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _buildBookInfo(
  BuildContext context,
  BookModel book,
  ChapterModel chapter,
  UserProgressModel progress,
) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: context.setMinSize(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.title, maxLines: 1, style: context.bodyLarge()),
          SizedBox(height: context.setMinSize(10)),
          Text(book.title, maxLines: 2, style: context.headlineSmall()),
          SizedBox(height: context.setMinSize(10)),
          Text(book.author!, style: context.bodyLarge()),
          SizedBox(height: context.setMinSize(10)),
          Expanded(child: _buildBookProgress(context, chapter, progress)),
        ],
      ),
    ),
  );
}

Widget _buildBookProgress(
  BuildContext context,
  ChapterModel chapter,
  UserProgressModel progress,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "Chapter ${chapter.chapterIndex}",
              style: context.bodyMedium(),
            ),
          ),
          SizedBox(width: context.setMinSize(6)),
          Text(
            "${(progress.progressPercentage * 100).toInt()}%",
            style: context.bodySmall().copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: context.setMinSize(10)),
          Container(
            width: context.setMinSize(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorTheme.surface,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow_outlined,
                size: context.setMinSize(24),
                color: context.colorTheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: context.setMinSize(8)),
      ProgressBar(progress: progress.progressPercentage),
    ],
  );
}

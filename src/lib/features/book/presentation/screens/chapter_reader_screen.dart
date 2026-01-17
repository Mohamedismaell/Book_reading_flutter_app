import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterReaderScreen extends StatelessWidget {
  const ChapterReaderScreen({
    super.key,
    // required this.bookId,
  });

  // final int bookId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, bookState) {
        if (bookState is BookLoading || bookState is BookInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookState is BookError) {
          return Center(child: Text(bookState.message));
        }

        if (bookState is BookLoaded) {
          return BlocBuilder<ChaptersCubit, ChaptersState>(
            builder: (context, chaptersState) {
              if (chaptersState is ChaptersIsLoading ||
                  chaptersState is ChaptersInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (chaptersState is ChaptersIsFailed) {
                return Center(child: Text(chaptersState.message));
              }

              if (chaptersState is ChaptersIsLoaded) {
                if (chaptersState.chapters.isEmpty) {
                  return const Center(child: Text('No chapters found'));
                }

                return ReaderView(
                  book: bookState.book,
                  chapters: chaptersState.chapters,
                );
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

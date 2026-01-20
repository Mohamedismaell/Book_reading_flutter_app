import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterReaderScreen extends StatelessWidget {
  const ChapterReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, bookState) => _buildBookStateUI(context, bookState),
    );
  }

  Widget _buildBookStateUI(BuildContext context, BookState state) {
    return switch (state) {
      BookLoading() || BookInitial() => _buildLoadingIndicator(),
      BookError(:final message) => _buildErrorMessage(message),
      BookLoaded(:final book) => _buildChaptersContent(context, book),
      // _ => const SizedBox.shrink(),
    };
  }

  Widget _buildChaptersContent(BuildContext context, book) {
    return BlocBuilder<ChaptersCubit, ChaptersState>(
      builder: (context, state) => _buildChaptersStateUI(context, state, book),
    );
  }

  Widget _buildChaptersStateUI(
    BuildContext context,
    ChaptersState state,
    book,
  ) {
    return switch (state) {
      ChaptersIsLoading() || ChaptersInitial() => _buildLoadingIndicator(),
      ChaptersIsFailed(:final message) => _buildErrorMessage(message),
      ChaptersIsLoaded(:final chapters) when chapters.isEmpty =>
        _buildEmptyMessage('No chapters found'),
      ChaptersIsLoaded(:final chapters) => ReaderView(
        book: book,
        chapters: chapters,
      ),
      // _ => const SizedBox.shrink(),
    };
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorMessage(String message) {
    return Center(child: Text(message));
  }

  Widget _buildEmptyMessage(String message) {
    return Center(child: Text(message));
  }
}

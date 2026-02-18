import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_id_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/progress/presentation/manager/reading_pregress/reading_progress_cubit.dart';
import 'package:bookreading/features/book/presentation/widgets/reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterReaderScreen extends StatefulWidget {
  final int bookId;
  const ChapterReaderScreen({super.key, required this.bookId});

  @override
  State<ChapterReaderScreen> createState() => _ChapterReaderScreenState();
}

class _ChapterReaderScreenState extends State<ChapterReaderScreen> {
  @override
  void initState() {
    context.read<BookIdCubit>().loadBook(widget.bookId);
    context.read<ChaptersCubit>().getChapters(widget.bookId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookIdCubit, BookIdState>(
      builder: (context, bookState) => _buildBookStateUI(context, bookState),
    );
  }

  Widget _buildBookStateUI(BuildContext context, BookIdState state) {
    return switch (state.bookStatus) {
      LoadStatus.loading || LoadStatus.initial => _buildLoadingIndicator(),
      LoadStatus.error => _buildErrorMessage(state.bookErrorMessage!),
      LoadStatus.loaded => _buildChaptersContent(context, state.book!),
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
      ChaptersIsLoaded(:final chapters) => BlocProvider(
        create: (context) => sl<ReadingProgressCubit>(),
        child: ReaderView(book: book, chapters: chapters),
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

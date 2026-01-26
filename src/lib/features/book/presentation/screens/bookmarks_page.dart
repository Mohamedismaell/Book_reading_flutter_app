import 'package:bookreading/features/book/data/models/book_marks.dart';
import 'package:bookreading/features/book/presentation/cubit/book_marks/book_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BookMarksCubit, BookMarksState>(
      builder: (context, state) {
        return switch (state) {
          BookMarksLoading() || BookMarksInitial() => _buildLoadingIndicator(),
          BookMarksError(:final message) => _buildErrorMessage(message),
          BookMarksLoaded(:final bookmarks) => _buildBookStateUI(
            context,
            bookmarks,
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

Widget _buildBookStateUI(BuildContext context, List<BookMarksModel> books) {
  return ListView(
    children: [for (var book in books) Text(book.bookDetails?.title ?? '')],
  );
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text(message));
}

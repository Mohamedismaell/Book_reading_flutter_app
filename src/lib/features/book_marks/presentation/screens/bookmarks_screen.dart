import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:bookreading/features/book_marks/presentation/manager/book_marks/book_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarksCubit, BookMarksState>(
      builder: (context, state) {
        return switch (state.bookmarksStatus) {
          LoadStatus.loading || LoadStatus.initial => _buildLoadingIndicator(),
          LoadStatus.error => _buildErrorMessage(state.errorMessage),
          LoadStatus.loaded => _buildBookStateUI(context, state.bookmarks),
          // _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

Widget _buildBookStateUI(BuildContext context, List<BookMarksModel> books) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: true,
        snap: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            Text('My Library'),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text(message));
}

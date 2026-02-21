import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/widget/horizontal_book_card.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/all_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key, required this.category});

  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBooksCubit, AllBooksState>(
      builder: (context, state) {
        if (state.status == LoadStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == LoadStatus.error) {
          return Center(child: Text("Error: ${state.message}"));
        }
        if (state.status == LoadStatus.loaded) {
          final books = state.books;
          return SizedBox(
            height: 310.h,
            // width: 160.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return HorizontalBookCard(book: book, category: category);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

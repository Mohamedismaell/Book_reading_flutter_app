import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/widget/vertical_cards_display.dart';
import 'package:bookreading/features/explore/presentation/manager/popular_books/popular_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularBooksDispaly extends StatelessWidget {
  const PopularBooksDispaly({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBooksCubit, PopularBooksState>(
      builder: (context, state) {
        if (state.status == LoadStatus.loading) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state.status == LoadStatus.error) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.message ?? 'Error')),
          );
        }
        return SliverList.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: state.books.length,
          itemBuilder: (context, index) {
            final book = state.books[index];
            return VerticalCardsDisplay(book: book);
          },
        );
      },
    );
  }
}

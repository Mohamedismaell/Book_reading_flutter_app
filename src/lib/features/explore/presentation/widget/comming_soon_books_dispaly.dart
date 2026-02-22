import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/widget/horizontal_book_card.dart';
import 'package:bookreading/features/explore/presentation/manager/comming_soon/comming_soon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommingSoonBooksDispaly extends StatelessWidget {
  const CommingSoonBooksDispaly({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommingSoonCubit, CommingSoonState>(
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
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 310.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return HorizontalBookCard(
                  book: book,
                  category: category,
                  // isTapable: false,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

import 'package:bookreading/core/widget/vertical_cards_display.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBookMarksSection extends StatelessWidget {
  const AllBookMarksSection({
    super.key,
    required this.state,
    required this.isFavorite,
  });

  final LibraryState state;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    if (isFavorite && state.bookMarksBooks.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Text('No Marked books yet'),
            ],
          ),
        ),
      );
    }
    if (!isFavorite && state.finishedBooks.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Text('No finished books yet , Start Reading'),
            ],
          ),
        ),
      );
    } else {
      return SliverList.builder(
        itemCount: isFavorite
            ? state.bookMarksBooks.length
            : state.finishedBooks.length,
        itemBuilder: (context, index) {
          final book = isFavorite
              ? state.bookMarksBooks[index].bookDetails
              : state.finishedBooks[index];

          return VerticalCardsDisplay(book: book);
        },
      );
    }
  }
}

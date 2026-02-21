import 'package:bookreading/core/widget/horizontal_book_card.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentFavoritesSection extends StatelessWidget {
  const RecentFavoritesSection({super.key, required this.state});

  final LibraryState state;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: SizedBox(
          height: 315.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.bookMarksBooks.length,
            itemBuilder: (context, index) {
              final book = state.bookMarksBooks[index].bookDetails;

              return HorizontalBookCard(category: 'Favorite', book: book);
            },
          ),
        ),
      ),
    );
  }
}

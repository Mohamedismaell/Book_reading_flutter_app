import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book_marks/presentation/manager/book_marks/book_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSavingIcon extends StatelessWidget {
  const CustomSavingIcon({
    super.key,
    required this.bookId,
    required this.iconSize,
  });

  final int bookId;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookMarksCubit, BookMarksState>(
      builder: (context, state) {
        final isBookmarked = state.isBookmarked(bookId);
        return InkWell(
          onTap: () {
            context.read<BookMarksCubit>().toggleBookmark(bookId: bookId);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              final curved = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              );
              return ScaleTransition(scale: curved, child: child);
            },
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,

              size: iconSize.sp,
              color: context.colorTheme.primary,
            ),
          ),
        );
      },
    );
  }
}

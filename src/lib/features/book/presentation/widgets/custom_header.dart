import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/cubit/book_marks/book_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    this.author,
    required this.bookId,
    required this.isheader,
    this.title,
  });
  final int bookId;
  final String? title;
  final String? author;
  final bool isheader;

  @override
  Widget build(BuildContext context) {
    //Todo fix theme
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => context.canPop() ? context.pop() : null,
          color: context.colorTheme.onSurface,
          icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
        ),
        // Spacer(),
        isheader
            ? Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(40),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: context.headlineMedium().copyWith(
                          color: context.colorTheme.onSurface.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        author!,
                        style: context.bodyLarge().copyWith(
                          fontSize: context.setSp(20),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),

        BlocBuilder<BookMarksCubit, BookMarksState>(
          builder: (context, state) {
            final isBookMarked = state is BookMarkActive;
            return GestureDetector(
              onTap: () {
                if (isBookMarked) {
                  print('***Removed BookMarks');
                  context.read<BookMarksCubit>().removeBookmark(bookId: bookId);
                } else {
                  print('***Added BookMarks');

                  context.read<BookMarksCubit>().saveBookMark(bookId: bookId);
                }
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
                  isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                  key: ValueKey(isBookMarked),
                  size: context.setMinSize(32),
                  color: context.colorTheme.primary,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

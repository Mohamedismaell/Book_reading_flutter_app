import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/all_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HorizontalView extends StatelessWidget {
  const HorizontalView({super.key, required this.category});
  final String category;

  // Theme.of(context);
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
          return _Content(books: state.books, category: category);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.books, required this.category});
  final List<BookModel> books;
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310.h,
      // width: 160.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: SizedBox(
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.pushNamed(
                        'bookDetails',
                        pathParameters: {'bookId': book.id.toString()},
                        extra: {
                          'heroTag': '${category}_${book.id}',
                          'coverUrl': book.coverUrl,
                          'title': book.title,
                          'author': book.author,
                        },
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 250.h,
                        child: Hero(
                          tag: '${category}_${book.id}',
                          child: Image.network(
                            book.coverUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 16.h),
                  _BookHeader(book: book),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BookHeader extends StatelessWidget {
  const _BookHeader({required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: context.textTheme.headlineSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            book.author ?? "Unknown",
            style: context.textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

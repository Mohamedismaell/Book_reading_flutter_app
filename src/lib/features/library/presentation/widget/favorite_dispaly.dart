import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FavoriteDispaly extends StatelessWidget {
  const FavoriteDispaly({
    super.key,
    required this.state,
    required this.bookMarksBooks,
    this.errorMessage,
  });
  final LoadStatus state;
  final String? errorMessage;
  final List<BookMarksModel> bookMarksBooks;
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      LoadStatus.initial => SliverToBoxAdapter(child: const SizedBox.shrink()),
      LoadStatus.loading => _buildLoadingIndicator(),
      LoadStatus.error => _buildErrorMessage(errorMessage!),
      LoadStatus.loaded => SliverList(
        delegate: SliverChildListDelegate([
          Row(
            children: [
              Text('Recent Favorites', style: context.textTheme.headlineMedium),
              Spacer(),
              Text(
                'View All',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: SizedBox(
              height: 315.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bookMarksBooks.length,
                itemBuilder: (context, index) {
                  final book = bookMarksBooks[index].bookDetails;

                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushNamed(
                              'bookDetails',
                              pathParameters: {'bookId': book.id.toString()},
                              extra: {
                                'heroTag': 'favorite_${book.id}',
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
                              width: 160.w,
                              height: 240.h,
                              child: Hero(
                                tag: 'favorite_${book.id}',
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
                  );
                },
              ),
            ),
          ),

          Row(
            children: [
              Text('All Bookmarks', style: context.textTheme.headlineMedium),
              Spacer(),
              Icon(Icons.segment),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              itemCount: bookMarksBooks.length,
              itemBuilder: (context, index) {
                final book = bookMarksBooks[index].bookDetails;
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: SizedBox(
                          width: 160.w,
                          height: 240.h,
                          child: Hero(
                            tag: 'favorite_${book.id}',
                            child: Image.network(
                              book.coverUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    };
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

Widget _buildLoadingIndicator() {
  return SliverToBoxAdapter(
    child: const Center(child: CircularProgressIndicator()),
  );
}

Widget _buildErrorMessage(String message) {
  return SliverToBoxAdapter(child: Center(child: Text(message)));
}

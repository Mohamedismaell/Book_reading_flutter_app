import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HorizontalBookCard extends StatelessWidget {
  const HorizontalBookCard({
    super.key,
    required this.book,
    required this.category,
    // required this.isTapable,
  });
  final String category;
  final BookModel book;
  // final bool isTapable;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: SizedBox(
        width: 160.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
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
                    // height: 250.h,
                    child: Hero(
                      tag: '${category}_${book.id}',
                      child: Image.network(book.coverUrl!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: context.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.author ?? "Unknown",
                  style: context.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/custom_saving_icon.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: SizedBox(
                              width: 64.w,
                              height: 96.h,
                              child: Image.network(
                                book.coverUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            book.title,
                                            style:
                                                context.textTheme.headlineSmall,
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
                                    CustomSavingIcon(
                                      bookId: book.id,
                                      iconSize: 24,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  (state.bookMarksBooks[index].createdAt)
                                      .toString(),
                                  style: context.textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 16.h),
                    // _BookHeader(book: book),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

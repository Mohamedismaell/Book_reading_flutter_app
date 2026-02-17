import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/widgets/book_over_view.dart';
import 'package:bookreading/features/book/presentation/widgets/custom_header.dart';
import 'package:bookreading/features/book/presentation/widgets/star_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatefulWidget {
  final int bookId;
  final Object? heroTag;
  final String? previewCover;
  final String? previewTitle;
  final String? previewAuthor;

  const BookDetailsScreen({
    super.key,
    required this.bookId,
    this.heroTag,
    this.previewCover,
    this.previewTitle,
    this.previewAuthor,
  });
  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookCubit>().loadBook(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, bookState) {
        final book = bookState is BookLoaded ? bookState.book : null;
        return Column(
          children: [
            CustomHeader(isheader: false, bookId: widget.bookId),
            _BookCover(
              coverUrl: book?.coverUrl ?? widget.previewCover!,
              title: book?.title ?? widget.previewTitle!,
              author: book?.author ?? widget.previewAuthor!,
              id: widget.bookId,
              heroTag: widget.heroTag,
            ),
            SizedBox(height: 35.h),

            if (bookState is BookLoaded)
              BookOverview(title: 'Overview', description: book!.summary!)
            else
              const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),

            SizedBox(height: 18.h),
            if (bookState is BookLoaded) _Buttons(book: book!),
          ],
        );
      },
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({
    required this.id,
    this.coverUrl,
    this.author,
    this.title,
    this.heroTag,
  });
  final String? coverUrl;
  final String? author;
  final String? title;
  final int id;
  final Object? heroTag;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 220.w,
              child: Hero(
                tag: heroTag ?? id,
                child: Image.network(coverUrl!, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            title ?? '',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: context.headlineMedium(),
          ),
          SizedBox(height: 10.h),
          Text(
            author ?? '',
            style: context.bodyLarge().copyWith(fontSize: 20.sp),
          ),
          SizedBox(height: 10.h),
          const Star(),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => context.push(
            AppRoutes.read.replaceFirst(':bookId', book.id.toString()),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 17.h),
          ),
          child: Text("Read", style: context.labelMedium()),
        ),
        SizedBox(width: 20.w),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 17.h),
            backgroundColor: AppSemanticColors.secondaryActionDark,
          ),

          child: Text("Listen", style: context.labelMedium()),
        ),
      ],
    );
  }
}

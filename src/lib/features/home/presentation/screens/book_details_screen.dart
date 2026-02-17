import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/home/presentation/manager/home/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/widgets/book_over_view.dart';
import 'package:bookreading/features/book/presentation/widgets/custom_header.dart';
import 'package:bookreading/features/book/presentation/widgets/star_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  final int bookId;
  final Object? heroTag;
  final String? coverUrl;
  final String? title;
  final String? author;

  const BookDetailsScreen({
    super.key,
    required this.bookId,
    this.heroTag,
    this.coverUrl,
    this.title,
    this.author,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadBook(bookId),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, bookState) {
          final book = bookState.bookStatus == LoadStatus.loaded
              ? bookState.book
              : null;
          return Column(
            children: [
              CustomHeader(isheader: false, bookId: bookId),
              _BookCover(
                coverUrl: book?.coverUrl ?? coverUrl!,
                title: book?.title ?? title!,
                author: book?.author ?? author!,
                id: bookId,
                heroTag: heroTag,
              ),
              SizedBox(height: 35.h),

              if (bookState.bookStatus == LoadStatus.loaded)
                BookOverview(title: 'Overview', description: book!.summary!)
              else
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),

              SizedBox(height: 18.h),
              if (bookState.bookStatus == LoadStatus.loaded)
                _Buttons(book: book!),
            ],
          );
        },
      ),
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

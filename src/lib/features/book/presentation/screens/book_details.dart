import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/book_over_view.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:bookreading/features/book/presentation/widget/star_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookDetails extends StatefulWidget {
  // final BookModel book;
  final Object? heroTag;
  const BookDetails({super.key, this.heroTag});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, bookState) {
        if (bookState is BookLoading || bookState is BookInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookState is BookError) {
          return Center(child: Text(bookState.message));
        }

        if (bookState is BookLoaded) {
          final book = bookState.book;
          return Column(
            children: [
              CustomHeader(isheader: false),
              _BookCover(
                coverUrl: book.coverUrl!,
                title: book.title,
                author: book.author!,
                id: book.id,
                heroTag: widget.heroTag,
              ),
              SizedBox(height: context.setHeight(35)),
              BookOverview(title: 'Overview', description: book.summary!),
              SizedBox(height: context.setHeight(18)),
              // SizedBox(height: context.setHeight()),
              _Buttons(book: book),
              // SizedBox(height: context.setHeight(25)),
            ],
          );
        }
        return Text("Error");
      },
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({
    required this.coverUrl,
    required this.author,
    required this.title,
    required this.id,
    this.heroTag,
  });
  final String coverUrl;
  final String author;
  final String title;
  final int id;
  final Object? heroTag;
  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(220, 430),
      width: context.setWidth(220),
      height: context.setHeight(430),
      child: Builder(
        builder: (context) {
          return SizedBox(
            // width: context.sizeProvider.width,
            // height: context.sizeProvider.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: context.sizeProvider.width,
                    // height: context.sizeProvider.height * 0.1,
                    child: Hero(
                      tag: heroTag ?? id,
                      child: Image.network(coverUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: context.setHeight(15)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium(),
                ),
                SizedBox(height: context.setHeight(10)),
                Text(
                  author,
                  style: context.bodyLarge().copyWith(
                    fontSize: context.setSp(20),
                  ),
                ),
                SizedBox(height: context.setHeight(10)),
                const Star(),
              ],
            ),
          );
        },
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
        //Todo fix the Button Later
        ElevatedButton(
          onPressed: () => context.push(AppRoutes.readPage, extra: book),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(50),
              vertical: context.setMinSize(17),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12),
            // ),
          ),
          child: Text("Read", style: context.labelMedium()),
        ),
        SizedBox(width: context.setWidth(20)),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(50),
              vertical: context.setMinSize(17),
            ),
            backgroundColor: AppSemanticColors.secondaryActionDark,
          ),

          child: Text("Listen", style: context.labelMedium()),
        ),
      ],
    );
  }
}

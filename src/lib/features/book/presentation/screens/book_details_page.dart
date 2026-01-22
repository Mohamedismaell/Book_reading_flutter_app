import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
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

class BookDetails extends StatefulWidget {
  final int bookId;
  final Object? heroTag;
  final String? previewCover;
  final String? previewTitle;
  final String? previewAuthor;

  const BookDetails({
    super.key,
    required this.bookId,
    this.heroTag,
    this.previewCover,
    this.previewTitle,
    this.previewAuthor,
  });
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
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
            CustomHeader(isheader: false),
            _BookCover(
              coverUrl: book?.coverUrl ?? widget.previewCover!,
              title: book?.title ?? widget.previewTitle!,
              author: book?.author ?? widget.previewAuthor!,
              id: widget.bookId,
              heroTag: widget.heroTag,
            ),
            SizedBox(height: context.setHeight(35)),

            if (bookState is BookLoaded)
              BookOverview(title: 'Overview', description: book!.summary!)
            else
              const Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(),
              ),

            SizedBox(height: context.setHeight(18)),
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
    return SizeProvider(
      baseSize: const Size(220, 430),
      width: context.setWidth(220),
      height: context.setHeight(430),
      child: Builder(
        builder: (context) {
          print('heroTag in widgfet  ==== ${heroTag}');
          return SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: context.sizeProvider.width,
                    child: Hero(
                      tag: heroTag ?? id,
                      child: Image.network(coverUrl!, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: context.setHeight(15)),
                Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: context.headlineMedium(),
                ),
                SizedBox(height: context.setHeight(10)),
                Text(
                  author ?? '',
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
        ElevatedButton(
          onPressed: () => context.push(
            AppRoutes.read.replaceFirst(':bookId', book.id.toString()),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(50),
              vertical: context.setMinSize(17),
            ),
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

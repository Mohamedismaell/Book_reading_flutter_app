import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/utils/text_paginator.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/books_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterReaderScreen extends StatefulWidget {
  const ChapterReaderScreen({super.key, required this.book});
  final BookModel book;
  @override
  State<ChapterReaderScreen> createState() => _ChapterReaderScreenState();
}

class _ChapterReaderScreenState extends State<ChapterReaderScreen> {
  @override
  void initState() {
    context.read<BooksCubit>().getChapters(widget.book.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is ChapterIsLoading) {
          return CircularProgressIndicator();
        }
        if (state is ChapterIsFaild) {
          return Text(state.message);
        }
        if (state is ChapterIsLoaded) {
          final chapter = state.chapters;
          return SizedBox(
            height: context.sizeProvider.height,
            child: Column(
              children: [
                CustomHeader(
                  isheader: true,
                  title: book.title,
                  author: book.author,
                ),
                SizedBox(height: context.setHeight(20)),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      print('here ${context.sizeProvider.height}');
                      print('here ${constraints.maxHeight}');
                      final pages = TextPaginator(
                        fullText: chapter[0].text,
                        width: context.sizeProvider.width,
                        height: constraints.maxHeight - context.setHeight(100),
                      ).paginate(style: context.bodyLarge());
                      return PageView(
                        children: pages
                            .map(
                              (page) => Text(
                                page,
                                style: context.bodyLarge().copyWith(
                                  // fontSize: 20,
                                  height: 1.6,
                                ),
                              ),
                            )
                            .toList(),
                      );

                      // ListView.builder(
                      //   itemCount: pages.length,
                      //   itemBuilder: (context, index) {
                      //     return Text(pages[index]);
                      //   },
                      // );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

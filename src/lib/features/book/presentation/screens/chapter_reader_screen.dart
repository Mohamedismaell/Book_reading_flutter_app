import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/utils/text_paginator.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:flutter/material.dart';

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
    context.read<ChaptersCubit>().getChapters(widget.book.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return BlocBuilder<ChaptersCubit, ChaptersState>(
      builder: (context, state) {
        if (state is ChaptersIsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ChaptersIsFailed) {
          return Center(child: Text(state.message));
        }
        if (state is ChaptersIsLoaded) {
          final chapter = state.chapters;
          if (chapter.isEmpty) {
            return Center(child: Text("No chapters found"));
          }
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
                      // The height of the Status Bar (Top)
                      double topPadding = MediaQuery.of(context).padding.top;

                      // The height of the Home Indicator (Bottom)
                      double bottomPadding = MediaQuery.of(
                        context,
                      ).padding.bottom;

                      // Total vertical safe area (Top + Bottom)
                      double totalSafeHeight = topPadding + bottomPadding;
                      //Todo fix the heghit of the text
                      final pages =
                          TextPaginator(
                            fullText: chapter[0].text,
                            width: context.sizeProvider.width,
                            height:
                                constraints.maxHeight -
                                MediaQuery.of(context).padding.top -
                                MediaQuery.of(context).padding.bottom,
                            // totalSafeHeight -
                            // context.setHeight(200),
                          ).paginate(
                            style: context.bodyLarge().copyWith(
                              height: 1.6,
                              fontSize: context.setSp(20),
                            ),
                          );
                      return PageView(
                        children: pages
                            .map(
                              (page) => Text(
                                page,
                                style: context.bodyLarge().copyWith(
                                  fontSize: context.setSp(20),
                                  height: 1.6,
                                ),
                              ),
                            )
                            .toList(),
                      );
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

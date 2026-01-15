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

  final Map<int, PageController> pageControllers = {};
  @override
  void dispose() {
    for (final controller in pageControllers.values) {
      controller.dispose();
    }
    super.dispose();
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
          final chapters = state.chapters;
          if (chapters.isEmpty) {
            return Center(child: Text("No chapters found"));
          }
          return SizedBox(
            height: context.sizeProvider.height,
            child: PageView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) => Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomHeader(
                    isheader: true,
                    title: book.title,
                    author: "Chapter ${index + 1}",
                  ),
                  SizedBox(height: context.setHeight(20)),
                  Expanded(
                    child: SafeArea(
                      top: false,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final pages =
                              TextPaginator(
                                fullText: chapters[index].text,
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                              ).paginate(
                                style: context.bodyLarge().copyWith(
                                  height: 1.6,
                                  fontSize: context.setSp(20),
                                ),
                              );
                          final pageController = pageControllers[index] ??=
                              PageController();
                          bool isAtStart = false;
                          bool isAtEnd = false;

                          if (pageController.hasClients) {
                            final position = pageController.position;
                            isAtStart =
                                position.pixels <= position.minScrollExtent;
                            isAtEnd =
                                position.pixels >= position.maxScrollExtent;
                          }
                          return PageView.builder(
                            controller: pageController,
                            physics: (isAtEnd || isAtStart)
                                ? const NeverScrollableScrollPhysics()
                                : const PageScrollPhysics(),
                            itemCount: pages.length,

                            itemBuilder: (context, index) => Text(
                              pages[index],
                              style: context.bodyLarge().copyWith(
                                fontSize: context.setSp(20),
                                height: 1.6,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/utils/text_paginator.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:bookreading/features/book/presentation/model/reader_paginator.dart';
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
  final PageController _pageControllers = PageController();
  final ValueNotifier<int> _currentChapterIndex = ValueNotifier(1);

  final ReaderPaginator _paginator = ReaderPaginator();
  List<PageData> _pages = [];
  double? _lastSize;
  double? _lastFontSize;
  double? _lastLineHeight;
  @override
  void initState() {
    context.read<ChaptersCubit>().getChapters(widget.book.id);
    super.initState();
  }

  @override
  void dispose() {
    _pageControllers.dispose();
    _currentChapterIndex.dispose();

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
          return Column(
            children: [
              _Header(book: book, currentChapterIndex: _currentChapterIndex),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final style = context.bodyLarge().copyWith(
                        fontSize: context.setSp(20),
                        height: 1.6,
                      );
                      final shouldRebuild = _lastSize != constraints.maxHeight;

                      if (shouldRebuild) {
                        _pages = _paginator.buildPages(
                          size: Size(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ),
                          chapters: chapters,
                          style: style,
                        );

                        _lastSize = constraints.maxHeight;
                      }

                      return _Content(
                        pages: _pages,
                        onPageChanged: (index) {
                          _currentChapterIndex.value =
                              _pages[index].chapterIndex;
                        },
                        pageController: _pageControllers,
                        style: style,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.book, required this.currentChapterIndex});
  final BookModel book;
  final ValueNotifier<int> currentChapterIndex;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentChapterIndex,
      builder: (context, chapterIndex, _) => CustomHeader(
        isheader: true,
        title: book.title,
        author: "Chapter $chapterIndex ",
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.pages,

    required this.onPageChanged,
    required this.pageController,
    required this.style,
  });
  final List<PageData> pages;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      itemCount: pages.length,
      onPageChanged: onPageChanged,

      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(18),
            vertical: context.setHeight(24),
          ),
          child: Text(pages[index].text, style: style),
        );
      },
    );
  }
}

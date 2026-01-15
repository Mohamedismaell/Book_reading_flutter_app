import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/utils/text_paginator.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:bookreading/features/book/presentation/model/reader.dart';
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
  final _pageControllers = PageController();

  final ValueNotifier<int> _currentChapterIndex = ValueNotifier(1);

  List<PageData> _allPages = [];
  void calculateAllPages({
    required String fullText,
    required double width,
    required double height,
    required List<ChapterModel> chapters,
    required TextStyle style,
  }) {
    List<PageData> tempList = [];
    for (final chapter in chapters) {
      final chapterPages = TextPaginator(
        fullText: chapter.text,
        width: width,
        height: height,
      ).paginate(style: style);
      for (int i = 0; i < chapterPages.length; i++) {
        tempList.add(
          PageData(
            text: chapterPages[i],
            chapterIndex: chapter.chapterIndex,
            pageNumber: i + 1,
          ),
        );
      }
      _allPages = tempList;
    }
  }

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
              ValueListenableBuilder<int>(
                valueListenable: _currentChapterIndex,
                builder: (context, chapterIndex, _) => CustomHeader(
                  isheader: true,
                  title: book.title,
                  author: "Chapter $chapterIndex ",
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final style = context.bodyLarge().copyWith(
                        fontSize: context.setSp(20),
                        height: 1.6,
                      );
                      calculateAllPages(
                        fullText: '',
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        chapters: chapters,
                        style: style,
                      );
                      return PageView.builder(
                        controller: _pageControllers,
                        scrollDirection: Axis.horizontal,
                        physics: const PageScrollPhysics(),
                        itemCount: _allPages.length,
                        onPageChanged: (index) {
                          _currentChapterIndex.value =
                              _allPages[index].chapterIndex;
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.setWidth(18),
                              vertical: context.setHeight(24),
                            ),
                            child: Text(_allPages[index].text, style: style),
                          );
                        },
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
/*
  
*/
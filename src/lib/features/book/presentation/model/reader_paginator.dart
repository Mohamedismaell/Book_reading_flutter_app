import 'package:bookreading/core/utils/text_paginator.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:flutter/rendering.dart';

class ReaderPaginator {
  List<PageData> buildPages({
    required Size size,
    required List<ChapterModel> chapters,
    required TextStyle style,
  }) {
    final List<PageData> pages = [];
    print("Looped 1 time");
    for (final chapter in chapters) {
      final chapterPages = TextPaginator(
        fullText: chapter.text,
        width: size.width,
        height: size.height,
      ).paginate(style: style);

      for (int i = 0; i < chapterPages.length; i++) {
        pages.add(
          PageData(
            text: chapterPages[i],
            chapterIndex: chapter.chapterIndex,
            pageNumber: i + 1,
          ),
        );
      }
    }

    return pages;
  }
}

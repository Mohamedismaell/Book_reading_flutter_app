import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/book/presentation/pagination/text_pagination_service.dart';
import 'package:flutter/material.dart';

class ReaderPaginationService {
  List<PageData> buildPages({
    required Size size,
    required List<ChapterModel> chapters,
    required TextStyle style,
  }) {
    final List<PageData> pages = [];

    for (final chapter in chapters) {
      final chapterPages = _paginateChapter(
        chapter: chapter,
        size: size,
        style: style,
      );

      pages.addAll(chapterPages);
    }

    return pages;
  }

  List<PageData> _paginateChapter({
    required ChapterModel chapter,
    required Size size,
    required TextStyle style,
  }) {
    final textPaginator = TextPaginationService(
      fullText: chapter.text,
      width: size.width,
      height: size.height,
    );

    final pageTexts = textPaginator.paginate(style: style);

    return List.generate(
      pageTexts.length,
      (index) => PageData(
        text: pageTexts[index],
        chapterIndex: chapter.chapterIndex,
        pageNumber: index + 1,
      ),
    );
  }
}

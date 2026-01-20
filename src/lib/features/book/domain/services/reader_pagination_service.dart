import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/book/domain/services/text_pagination_service.dart';
import 'package:flutter/rendering.dart';

class ReaderPaginationService {
  List<PageData> buildPages({
    required Size size,
    required List<ChapterModel> chapters,
    required TextStyle style,
  }) {
    final List<PageData> pages = [];
    print("Looped 1 time");

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

  static double calculateProgress({
    required List<PageData> pages,
    required int currentPageIndex,
  }) {
    if (pages.isEmpty || currentPageIndex <= 0) return 0.0;

    int charactersRead = 0;
    final safeIndex = (currentPageIndex - 1).clamp(0, pages.length - 1);

    for (int i = 0; i <= safeIndex; i++) {
      charactersRead += pages[i].contentLength;
    }
    //! Ask later about fold
    final totalCharacters = pages.fold<int>(
      0,
      (sum, page) => sum + page.contentLength,
    );

    if (totalCharacters == 0) return 0.0;

    return charactersRead / totalCharacters;
  }
}

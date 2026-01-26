import 'package:bookreading/features/book/domain/entities/page_data.dart';

class ReadingProgressCalculator {
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
    final totalCharacters = pages.fold<int>(
      0,
      (sum, page) => sum + page.contentLength,
    );

    if (totalCharacters == 0) return 0.0;

    return charactersRead / totalCharacters;
  }
}

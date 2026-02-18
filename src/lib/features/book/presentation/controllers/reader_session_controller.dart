import 'dart:async';

import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/progress/presentation/manager/reading_pregress/reading_progress_cubit.dart';
import 'package:flutter/material.dart';

class ReaderSessionController {
  ReaderSessionController({
    required ReadingProgressCubit readingProgressCubit,
    // required UserStatsCubit userStatsCubit,
    required BookModel book,
    required List<ChapterModel> chapters,
  }) : _readingProgressCubit = readingProgressCubit,
       //  _userStatsCubit = userStatsCubit,
       _book = book,
       _chapters = chapters;

  final ReadingProgressCubit _readingProgressCubit;
  // final UserStatsCubit _userStatsCubit;
  final BookModel _book;
  final List<ChapterModel> _chapters;

  final PageController pageController = PageController();

  final ValueNotifier<int> currentPageIndex = ValueNotifier(1);
  final ValueNotifier<int> currentChapterIndex = ValueNotifier(1);
  final ValueNotifier<bool> areToolsVisible = ValueNotifier(true);
  Timer? _progressTimer;
  int _lastSavedPage = 0;
  final DateTime _startReadingTime = DateTime.now();

  List<PageData> _pages = [];
  void toggleTools() {
    areToolsVisible.value = !areToolsVisible.value;
  }

  void onPageChanged(int index) {
    currentChapterIndex.value = _pages[index].chapterIndex;
    currentPageIndex.value = index + 1;
  }

  void dispose() {
    _progressTimer?.cancel();
    pageController.dispose();
    currentPageIndex.dispose();
    currentChapterIndex.dispose();
    areToolsVisible.dispose();
  }

  void updatePages(List<PageData> pages) {
    _pages = pages;
  }

  void onExit() {
    final readingDuration = DateTime.now().difference(_startReadingTime);

    if (readingDuration.inSeconds >= 3) {
      final progress = _readingProgressCubit.calculateProgress(
        pages: _pages,
        currentPageIndex: currentPageIndex.value,
      );
      _trySaveProgress(progress);
    }
  }

  void _trySaveProgress(double progress) {
    if (_pages.isEmpty) return;

    final currentPage = currentPageIndex.value;
    final chapterIndex = currentChapterIndex.value - 1;

    if (chapterIndex < 0 || chapterIndex >= _chapters.length) return;

    _readingProgressCubit.saveProgress(
      bookId: _book.id,
      chapterId: _chapters[chapterIndex].id,
      activeBook: _book,
      activeChapter: _chapters[chapterIndex],
      pageNumber: currentPage,
      progress: progress,
    );
    print("Progress Saved Successfully");
    _lastSavedPage = currentPage;
  }

  void start() {
    _progressTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pages.isEmpty) return;

      if (currentPageIndex.value != _lastSavedPage) {
        final progress = _readingProgressCubit.calculateProgress(
          pages: _pages,
          currentPageIndex: currentPageIndex.value,
        );

        _trySaveProgress(progress);
      }
    });
  }
}

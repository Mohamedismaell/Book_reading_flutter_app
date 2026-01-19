import 'dart:async';

import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:bookreading/features/book/presentation/model/reader_paginator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/service_locator.dart';

class ReaderView extends StatefulWidget {
  const ReaderView({super.key, required this.chapters, required this.book});
  final List<ChapterModel> chapters;
  final BookModel book;
  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  final PageController _pageControllers = PageController();
  final ValueNotifier<int> _currentChapterIndex = ValueNotifier(1);
  final ValueNotifier<bool> _areToolsVisible = ValueNotifier(true);

  final ValueNotifier<int> _currentPageIndex = ValueNotifier(1);
  final ReaderPaginator _paginator = ReaderPaginator();
  List<PageData> _pages = [];
  double? _lastSize;
  int _lastSavedPage = 0;
  double _progress = 0;
  // bool _areToolsVisible = false;

  void _toggleTools() {
    _areToolsVisible.value = !_areToolsVisible.value;
  }

  void _handleBack() {
    _saveProgress();
    if (context.canPop()) {
      // context.read<ReadingProgressCubit>().setProgress(_progress);
      context.pop();
    }
  }

  Timer? _progressTimer;

  void _saveProgress() {
    //! danger
    if (_pages.isEmpty) return;
    final currentPage = _currentPageIndex.value;
    final chapterIndex = _currentChapterIndex.value - 1;
    if (chapterIndex < 0 || chapterIndex >= widget.chapters.length) return;

    final user = sl<SupabaseClient>().auth.currentUser;
    if (user == null) {
      print(" Cannot save progress: User not logged in.");
      return;
    }

    context.read<ReadingProgressCubit>().saveProgress(
      bookId: widget.book.id!,
      userId: user.id,
      chapterId: widget.chapters[chapterIndex].id!,
      currentPage: currentPage,
      totalPages: _pages.length,
      activeBook: widget.book,
      activeChapter: widget.chapters[chapterIndex],
    );
    print("Saved ");
    _lastSavedPage = currentPage;
  }

  @override
  void initState() {
    _progressTimer = Timer.periodic(
      Duration(seconds: 5),
      (_) => _currentPageIndex.value != _lastSavedPage ? _saveProgress() : null,
    );
    super.initState();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _pageControllers.dispose();
    _currentChapterIndex.dispose();
    _currentPageIndex.dispose();
    _areToolsVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadingProgressCubit, ReadingProgressState>(
      listener: (context, state) {
        if (state is ReadingProgressSaved) {
          print("✅ Progress Saved Successfully via Cubit");
          // Optional: Show lightweight feedback
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Progress Saved")));
        } else if (state is ReadingProgressError) {
          print("❌ Error Saving Progress: ${state.message}");
        }
      },
      child: Stack(
        // mainAxisSize: MainAxisSize.min,
        children: [
          _Header(
            book: widget.book,
            currentChapterIndex: _currentChapterIndex,
            areToolsVisible: _areToolsVisible,
            onTap: _handleBack,
          ),
          Positioned(
            top: context.setMinSize(56),
            bottom: context.setMinSize(56),
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _toggleTools(),
              child: SafeArea(
                top: false,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final style = context.bodyLarge().copyWith(
                      fontSize: context.setSp(20),
                      height: 1.4,
                    );
                    final shouldRebuild = _lastSize != constraints.maxHeight;

                    if (shouldRebuild) {
                      _pages = _paginator.buildPages(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        chapters: widget.chapters,
                        style: style,
                      );

                      _lastSize = constraints.maxHeight;
                    }

                    return _Content(
                      pages: _pages,
                      onPageChanged: (index) {
                        _currentChapterIndex.value = _pages[index].chapterIndex;
                        _currentPageIndex.value = index + 1;
                      },
                      pageController: _pageControllers,
                      style: style,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _Footer(
              areToolsVisible: _areToolsVisible,
              currentIndexNotifier: _currentPageIndex,
              pages: _pages,
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.book,
    required this.currentChapterIndex,
    required this.areToolsVisible,
    required this.onTap,
  });
  final BookModel book;
  final ValueNotifier<int> currentChapterIndex;
  final ValueNotifier<bool> areToolsVisible;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: areToolsVisible,
      builder: (context, areToolsVisible, _) => SizedBox(
        height: context.setMinSize(56),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IgnorePointer(
                ignoring: !areToolsVisible,
                child: AnimatedOpacity(
                  opacity: areToolsVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: onTap,
                    color: context.colorTheme.onSurface,
                    icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: currentChapterIndex,
              builder: (context, chapterIndex, child) => Center(
                child: Text(
                  areToolsVisible ? book.author! : "Chapter $chapterIndex ",
                  style: context.bodyMedium().copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
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
        return Text(
          textAlign: TextAlign.start,
          pages[index].text,
          style: style,
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.areToolsVisible,
    required this.currentIndexNotifier,
    required this.pages,
  });

  final ValueNotifier<bool> areToolsVisible;
  final ValueNotifier<int> currentIndexNotifier;
  final List<PageData> pages;
  @override
  Widget build(BuildContext context) {
    // final int currentPage = currentIndexNotifier.value;
    // final int totalPages = pages.length;
    // progress = totalPages == 0 ? 0 : (currentPage / totalPages) * 100;
    // print('progress $progress');
    return ValueListenableBuilder<bool>(
      valueListenable: areToolsVisible,
      builder: (context, visible, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: !visible ? 0 : 1,
          child: IgnorePointer(
            ignoring: !visible,
            child: SizedBox(
              width: context.sizeProvider.width,
              height: context.setMinSize(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: context.sizeProvider.width / 4),
                  Expanded(
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: currentIndexNotifier,
                        builder: (context, index, _) {
                          if (pages.isEmpty || index <= 0) {
                            return const SizedBox.shrink();
                          }

                          final safeIndex = (index - 1).clamp(
                            0,
                            pages.length - 1,
                          );
                          final data = pages[safeIndex];

                          return Text(
                            "${data.pageNumber} / ${pages.length}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          );
                        },
                      ),
                    ),
                  ),
                  // SizedBox(width: context.sizeProvider.width / 4),
                  // context.setMinSize(60)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setMinSize(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorTheme.primary.withOpacity(
                          0.8,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(context.setMinSize(10)),
                      ),
                      child: Icon(
                        Icons.view_list_rounded,
                        size: context.setMinSize(40),
                      ),

                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

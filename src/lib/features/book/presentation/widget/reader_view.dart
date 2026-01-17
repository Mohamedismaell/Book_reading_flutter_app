import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/presentation/model/page_data.dart';
import 'package:bookreading/features/book/presentation/model/reader_paginator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  // bool _areToolsVisible = false;

  void _toggleTools() {
    _areToolsVisible.value = !_areToolsVisible.value;
  }

  @override
  void dispose() {
    _pageControllers.dispose();
    _currentChapterIndex.dispose();
    _areToolsVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        _Header(
          book: widget.book,
          currentChapterIndex: _currentChapterIndex,
          areToolsVisible: _areToolsVisible,
        ),
        Expanded(
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
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() {});
                    });
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
        _Footer(
          areToolsVisible: _areToolsVisible,
          currentIndexNotifier: _currentPageIndex,
          pages: _pages,
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.book,
    required this.currentChapterIndex,
    required this.areToolsVisible,
  });
  final BookModel book;
  final ValueNotifier<int> currentChapterIndex;
  final ValueNotifier<bool> areToolsVisible;

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
                ignoring: areToolsVisible,
                child: AnimatedOpacity(
                  opacity: areToolsVisible ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () => context.canPop() ? context.pop() : null,
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
    return ValueListenableBuilder<bool>(
      valueListenable: areToolsVisible,
      builder: (context, visible, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: !visible ? 0 : 1,
          child: IgnorePointer(
            ignoring: !visible,
            child: Container(
              color: Colors.red,
              width: context.sizeProvider.width,
              height: context.setMinSize(56),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Center page number
                  ValueListenableBuilder<int>(
                    valueListenable: currentIndexNotifier,
                    builder: (context, index, _) {
                      if (pages.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final safeIndex = (index - 1).clamp(0, pages.length - 1);
                      final data = pages[safeIndex];
                      return Text(
                        "${data.pageNumber} / ${pages.length}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    },
                  ),

                  // Right-aligned icon
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(Icons.list, size: context.setMinSize(40)),
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

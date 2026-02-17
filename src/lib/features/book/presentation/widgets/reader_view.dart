import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/book/presentation/controllers/reader_session_controller.dart';
import 'package:bookreading/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
import 'package:bookreading/features/book/presentation/pagination/reader_pagination_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReaderView extends StatefulWidget {
  const ReaderView({super.key, required this.chapters, required this.book});

  final List<ChapterModel> chapters;
  final BookModel book;

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  late final ReaderSessionController controller;
  final ReaderPaginationService _paginationService = ReaderPaginationService();

  List<PageData> _pages = [];
  double? _lastSize;
  @override
  void initState() {
    super.initState();
    controller = ReaderSessionController(
      readingProgressCubit: context.read(),
      userStatsCubit: context.read(),
      book: widget.book,
      chapters: widget.chapters,
    );
    controller.start();
  }

  void _handleBack() {
    controller.onExit();
    if (context.canPop()) {
      context.pop();
    }
  }

  void _buildPagesIfNeeded(BoxConstraints constraints, TextStyle style) {
    final shouldRebuild = _lastSize != constraints.maxHeight;

    if (shouldRebuild) {
      _pages = _paginationService.buildPages(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        chapters: widget.chapters,
        style: style,
      );
      controller.updatePages(_pages);
      _lastSize = constraints.maxHeight;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReadingProgressCubit, ReadingProgressState>(
      listener: _handleProgressState,
      child: Stack(children: [_buildHeader(), _buildContent(), _buildFooter()]),
    );
  }

  void _handleProgressState(BuildContext context, ReadingProgressState state) {
    // if (state is ReadingProgressSaved) {
    //   print("✅ Progress Saved Successfully via Cubit");
    // } else if (state is ReadingProgressError) {
    //   print("❌ Error Saving Progress: ${state.message}");
    // }
  }

  Widget _buildHeader() {
    return ReaderHeader(
      book: widget.book,
      currentChapterIndex: controller.currentChapterIndex,
      areToolsVisible: controller.areToolsVisible,
      onTap: _handleBack,
    );
  }

  Widget _buildContent() {
    return Positioned(
      top: 60.h,
      bottom: 60.h,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: controller.toggleTools,
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final style = context.bodyLarge().copyWith(
                fontSize: 20.sp,
                height: 1.4,
              );

              _buildPagesIfNeeded(constraints, style);

              return ReaderContent(
                pages: _pages,
                onPageChanged: (index) => controller.onPageChanged(index),
                pageController: controller.pageController,
                style: style,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ReaderFooter(
        areToolsVisible: controller.areToolsVisible,
        currentIndexNotifier: controller.currentPageIndex,
        pages: _pages,
      ),
    );
  }
}

class ReaderHeader extends StatelessWidget {
  const ReaderHeader({
    super.key,
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
      builder: (context, visible, _) => SizedBox(
        height: 56.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildBackButton(context, visible),
            _buildTitle(context, visible),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, bool visible) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        ignoring: !visible,
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: onTap,
            color: context.colorTheme.onSurface,
            icon: Icon(Icons.arrow_back, size: 26.r),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool visible) {
    return ValueListenableBuilder<int>(
      valueListenable: currentChapterIndex,
      builder: (context, chapterIndex, child) => Center(
        child: Text(
          visible ? book.author! : "Chapter $chapterIndex ",
          style: context.bodyMedium().copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class ReaderContent extends StatelessWidget {
  const ReaderContent({
    super.key,
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

class ReaderFooter extends StatelessWidget {
  const ReaderFooter({
    super.key,
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
          opacity: visible ? 1 : 0,
          child: IgnorePointer(
            ignoring: !visible,
            child: SizedBox(
              width: 1.sw,
              height: 100.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 0.25.sw),
                  Expanded(child: _buildPageIndicator(context)),
                  _buildChapterListButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: currentIndexNotifier,
        builder: (context, index, _) {
          if (pages.isEmpty || index <= 0) {
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
    );
  }

  Widget _buildChapterListButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorTheme.primary.withOpacity(0.8),
          shape: const CircleBorder(),
          padding: EdgeInsets.all(10.r),
        ),
        onPressed: () {},
        child: Icon(Icons.view_list_rounded, size: 40.r),
      ),
    );
  }
}

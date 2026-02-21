import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/core/widget/custom_saving_icon.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:bookreading/features/library/presentation/widget/all_book_marks_section.dart';
import 'package:bookreading/features/library/presentation/widget/library_app_bar.dart';
import 'package:bookreading/features/library/presentation/widget/recent_favorites_section.dart';
import 'package:bookreading/features/library/presentation/widget/section_header.dart';
import 'package:bookreading/features/library/presentation/widget/track_finished_books.dart';
import 'package:bookreading/features/library/presentation/widget/type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryCubit, LibraryState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            LibraryAppBar(),
            _TabsSection(state: state),
            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            if (state.isFavoriteScreen) ...[
              SectionHeader(title: 'Recent Favorites', isRecentFavorites: true),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              RecentFavoritesSection(state: state),
              SectionHeader(title: 'All Bookmarks', isRecentFavorites: false),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              AllBookMarksSection(state: state, isFavorite: true),
            ] else ...[
              TrackFinishedBooks(state: state),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SectionHeader(
                title: 'Recent Favorites',
                isRecentFavorites: false,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              AllBookMarksSection(state: state, isFavorite: false),
            ],
          ],
        );
      },
    );
  }
}

class _TabsSection extends StatelessWidget {
  const _TabsSection({required this.state});
  final LibraryState state;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: Row(
            children: [
              LibraryTypeButton(
                title: 'Favorites',
                onPressed: () {
                  context.read<LibraryCubit>().showFavorites();
                  // context.read<LibraryCubit>().fetchAllBookmarks();
                },
                isActive: state.isFavoriteScreen,
              ),
              LibraryTypeButton(
                title: 'Finished Books',
                onPressed: () {
                  context.read<LibraryCubit>().showFinished();
                },
                isActive: !state.isFavoriteScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

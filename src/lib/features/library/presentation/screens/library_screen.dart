import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:bookreading/features/library/presentation/widget/favorite_dispaly.dart';
import 'package:bookreading/features/library/presentation/widget/finished_books_dispaly.dart';
import 'package:bookreading/features/library/presentation/widget/library_app_bar.dart';
import 'package:bookreading/features/library/presentation/widget/type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        LibraryAppBar(),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: context.colorTheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: BlocBuilder<LibraryCubit, LibraryState>(
                builder: (context, state) {
                  // context.read<LibraryCubit>().fetchAllBookmarks();
                  return Row(
                    children: [
                      LibraryTypeButton(
                        title: 'Favorites',
                        onPressed: () {
                          state.isFavoriteScreen = true;
                          context.read<LibraryCubit>().fetchAllBookmarks();
                        },
                        isActive: state.isFavoriteScreen,
                      ),
                      LibraryTypeButton(
                        title: 'Finished Books',
                        onPressed: () {
                          state.isFavoriteScreen = false;
                          context.read<LibraryCubit>().fetchFinishedBooks();
                        },
                        isActive: !state.isFavoriteScreen,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, state) {
            return state.isFavoriteScreen
                ? FavoriteDispaly(
                    state: state.status,
                    bookMarksBooks: state.bookMarksBooks,
                    errorMessage: state.errorMessage,
                  )
                : FinishedBooksDispaly();
          },
        ),
      ],
    );
  }
}

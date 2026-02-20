import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
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
            SliverAppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              floating: true,
              snap: true,
              automaticallyImplyLeading: false,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Library'),
                  // Spacer(),
                  InkWell(
                    onTap: () {
                      //Show menu or something
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFF27272A),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.r),
                  child: BlocBuilder<LibraryCubit, LibraryState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          TypeButton(
                            title: 'Favorites',
                            onPressed: () {
                              state.isFavoriteScreen = true;
                              context.read<LibraryCubit>().fetchAllBookmarks();
                            },
                            isActive: state.isFavoriteScreen,
                          ),
                          TypeButton(
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
          ],
        );
      },
    );
  }
}
//  switch (state.status) {
//           LoadStatus.loading || LoadStatus.initial => _buildLoadingIndicator(),
//           LoadStatus.error => _buildErrorMessage(state.errorMessage!),
//           LoadStatus.loaded => _buildBookStateUI(context),
//           // _ => const SizedBox.shrink(),
//         };

Widget _buildLoadingIndicator() {
  return const Center(child: CircularProgressIndicator());
}

Widget _buildErrorMessage(String message) {
  return Center(child: Text(message));
}

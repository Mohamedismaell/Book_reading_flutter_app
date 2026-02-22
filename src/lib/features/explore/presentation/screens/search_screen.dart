import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/widget/vertical_cards_display.dart';
import 'package:bookreading/features/explore/presentation/manager/search/search_cubit.dart';
import 'package:bookreading/features/explore/presentation/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  // final String heroTag;
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            const CustomSearchBar(isTapable: false),
            Expanded(
              child: Scrollbar(
                controller: controller,
                thumbVisibility: true,
                thickness: 3,
                radius: const Radius.circular(10),
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    const _SearchContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: state.searchResults.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: VerticalCardsDisplay(book: state.searchResults[index]),
          ),
        );
      },
    );
  }
}

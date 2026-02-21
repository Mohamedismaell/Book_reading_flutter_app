import 'package:bookreading/core/shared/injection/service_locator.dart';
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
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomSearchBar(),
              Expanded(
                child: Scrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  thickness: 6,
                  radius: const Radius.circular(10),
                  child: CustomScrollView(
                    controller: controller,
                    slivers: const [_SearchContent()],
                  ),
                ),
              ),
            ],
          ),
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
          itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            leading: Icon(Icons.access_time),
            title: Text(maxLines: 1, state.searchResults[index].title),
            trailing: Transform.rotate(
              angle: 4,
              child: Icon(Icons.arrow_forward_sharp),
            ),
          ),
        );
      },
    );
  }
}

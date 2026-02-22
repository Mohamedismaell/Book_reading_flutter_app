import 'package:bookreading/features/explore/presentation/widget/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: InkWell(
            onTap: () {},
            child: CustomSearchBar(
              isTapable: true,
              onTap: () {
                context.pushNamed('search');
              },
            ),
          ),
        ),
        SliverToBoxAdapter(child: Center(child: Text('Explore Screen'))),
      ],
    );
  }
}

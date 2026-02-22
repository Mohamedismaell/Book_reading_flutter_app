import 'package:bookreading/core/widget/section_header.dart';
import 'package:bookreading/features/explore/presentation/widget/comming_soon_books_dispaly.dart';
import 'package:bookreading/features/explore/presentation/widget/custom_search_bar.dart';
import 'package:bookreading/features/explore/presentation/widget/popular_books_dispaly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomSearchBar(
            isTapable: true,
            onTap: () {
              context.pushNamed('search');
            },
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        SectionHeader(title: 'Up Coming Soon', isRecentFavorites: false),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        CommingSoonBooksDispaly(category: 'upcoming'),
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        SectionHeader(title: 'Popular Books', isRecentFavorites: true),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        PopularBooksDispaly(category: 'popular'),
      ],
    );
  }
}

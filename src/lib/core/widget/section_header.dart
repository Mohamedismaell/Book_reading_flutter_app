import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isRecentFavorites;
  const SectionHeader({
    super.key,
    required this.title,
    required this.isRecentFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(title, style: context.textTheme.headlineMedium),
          const Spacer(),
          isRecentFavorites
              ? Text(
                  'View All',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorTheme.primary,
                  ),
                )
              : Icon(Icons.segment),
        ],
      ),
    );
  }
}

import 'package:bookreading/features/explore/presentation/screens/search_screen.dart';
import 'package:flutter/widgets.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverToBoxAdapter(child: SearchScreen())],
    );
  }
}

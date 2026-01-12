import 'package:bookreading/features/book/presentation/screens/bookmarks_page.dart';
import 'package:bookreading/features/book/presentation/screens/explore_page.dart';
import 'package:bookreading/features/book/presentation/screens/home_page.dart';
import 'package:bookreading/features/book/presentation/screens/profile_page.dart';
import 'package:bookreading/features/book/presentation/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

class TabsShell extends StatefulWidget {
  const TabsShell({super.key});

  @override
  State<TabsShell> createState() => _TabsShellState();
}

class _TabsShellState extends State<TabsShell> {
  final pageController = PageController();
  int _currentIndex = 0;

  void _onTabTap(int index) {
    if (!pageController.hasClients) return;
    final current = pageController.page?.round() ?? _currentIndex;
    final distance = (index - current).abs();

    if (distance >= 1) {
      int neighbor = index > _currentIndex ? index - 1 : index + 1;
      pageController.jumpToPage(neighbor);
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          if (mounted) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        children: [
          const HomePage(),
          const ExplorePage(),
          const BookmarksPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
      ),
    );
  }
}

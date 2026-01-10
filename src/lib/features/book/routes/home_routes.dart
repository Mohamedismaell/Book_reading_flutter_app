import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/features/book/presentation/screens/bookmarks_page';
import 'package:bookreading/features/book/presentation/screens/explore_page.dart';
import 'package:bookreading/features/book/presentation/screens/home_page.dart';
import 'package:bookreading/features/book/presentation/screens/profile_page.dart';
import 'package:bookreading/features/book/presentation/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/orb_position.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widget/orb.dart';
import '../presentation/screens/book_details.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        return _MainShell(showNav: true, child: child);
      },

      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),

        GoRoute(
          path: AppRoutes.explore,
          builder: (context, state) => const ExplorePage(),
        ),
        GoRoute(
          path: AppRoutes.bookmarks,
          builder: (context, state) => const BookmarksPage(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    ShellRoute(
      routes: [
        GoRoute(
          path: AppRoutes.bookDetails,
          builder: (context, state) => const BookDetails(),
        ),
      ],
      builder: (context, state, child) =>
          _MainShell(showNav: false, child: child),
    ),
  ];
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child, required this.showNav});
  final Widget child;
  final bool showNav;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Orb(position: OrbPosition.topLeft),
          Orb(position: OrbPosition.centerRight, isCyan: false),
          Orb(position: OrbPosition.bottomRight),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.only(
                right: context.setWidth(20),
                left: context.setWidth(20),
                top: context.setHeight(5),
              ),
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: showNav ? BottomNav() : null,
    );
  }
}

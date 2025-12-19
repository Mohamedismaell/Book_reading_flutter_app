import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({super.key, required this.currentLocation});
  final String currentLocation;

  int get _selectedIndex {
    if (currentLocation.startsWith(AppRoutes.categories)) {
      return 1;
    }
    if (currentLocation.startsWith(AppRoutes.bookmarks)) {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      indicatorColor: Colors.transparent,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.go(AppRoutes.home);
            break;
          case 1:
            context.go(AppRoutes.categories);
            break;
          case 2:
            context.go(AppRoutes.bookmarks);
            break;
        }
      },
      destinations: [
        NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: ''),
        NavigationDestination(
            icon: Icon(
              Icons.grid_view_outlined,
            ),
            label: ''),
        NavigationDestination(
            icon: Icon(
              Icons.bookmark_outline_sharp,
            ),
            label: ''),
      ],
    );
  }
}

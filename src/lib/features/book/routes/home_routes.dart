import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/navigaiton/tabs_shell.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/screens/chapter_reader_screen.dart';
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
        return _MainShell(child: child);
      },

      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const TabsShell(),
        ),
      ],
    ),
    ShellRoute(
      routes: [
        GoRoute(
          path: AppRoutes.bookDetails,

          builder: (context, state) {
            final extra = state.extra;
            BookModel book;
            Object? heroTag;

            if (extra is BookModel) {
              book = extra;
            } else if (extra is Map) {
              book = extra['book'] as BookModel;
              heroTag = extra['heroTag'];
            } else {
              // Handle unexpected type or null, possibly show error or fallback
              throw Exception('Invalid extra for BookDetails');
            }
            return BookDetails(book: book, heroTag: heroTag);
          },
        ),
        GoRoute(
          path: AppRoutes.readPage,

          builder: (context, state) =>
              ChapterReaderScreen(book: state.extra as BookModel),
        ),
      ],
      builder: (context, state, child) => _MainShell(child: child),
    ),
  ];
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});
  final Widget child;
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
                // top: context.setHeight(5),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/navigaiton/tabs_shell.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/screens/chapter_reader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enums/orb_position.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widget/orb.dart';
import '../presentation/screens/book_details_page.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        return _MainShell(usePadding: false, child: child);
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
            final bookId = int.parse(state.pathParameters['bookId']!);
            final extra = state.extra as Map<String, dynamic>?;
            final herotag = extra?['herotag'];
            // context.read<BookCubit>().loadBook(bookId);
            return BookDetails(
              bookId: bookId,
              heroTag: extra?['heroTag'],
              previewCover: extra?['coverUrl'],
              previewTitle: extra?['title'],
              previewAuthor: extra?['author'],
            );
          },
        ),
        GoRoute(
          path: AppRoutes.read,

          builder: (context, state) {
            final bookId = int.parse(state.pathParameters['bookId']!);

            context.read<BookCubit>().loadBook(bookId);
            context.read<ChaptersCubit>().getChapters(bookId);

            return ChapterReaderScreen();
          },
        ),
      ],
      builder: (context, state, child) => _MainShell(child: child),
    ),
  ];
}

class _MainShell extends StatelessWidget {
  const _MainShell({required this.child, this.usePadding = true});
  final Widget child;
  final bool usePadding;
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
                right: usePadding ? context.setWidth(20) : 0,
                left: usePadding ? context.setWidth(20) : 0,
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

import 'package:bookreading/core/enums/orb_position.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/widget/connection_banner.dart';
import 'package:bookreading/core/widget/orb.dart';
import 'package:bookreading/features/book_marks/presentation/manager/book_marks/book_marks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_app/core/connection/connection_visibility.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({super.key, required this.child, required this.location});

  @override
  Widget build(BuildContext context) {
    // final showBanner = shouldShowConnectionBanner(location);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BookMarksCubit>()..fetchBookMarksId(),
        ),
      ],
      child: Scaffold(
        // extendBody: true,
        body: Stack(
          children: [
            Orb(position: OrbPosition.topLeft),
            Orb(position: OrbPosition.centerRight, isCyan: false),
            Orb(position: OrbPosition.bottomRight),
            SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  child,
                  // if (showBanner)
                  const Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: ConnectionBanner(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

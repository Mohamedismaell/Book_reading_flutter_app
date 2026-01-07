import 'package:bookreading/features/book/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/enums/orb_position.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widget/orb.dart';
import '../presentation/screens/book_details.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: Stack(
            children: [
              Orb(position: OrbPosition.topLeft),
              Orb(position: OrbPosition.centerRight, isCyan: false),
              Orb(position: OrbPosition.bottomRight),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 5.h),
                  child: child,
                ),
              ),
            ],
          ),
        );
      },

      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.bookDetails,
          builder: (context, state) => const BookDetails(),
        ),
      ],
    ),
  ];
}

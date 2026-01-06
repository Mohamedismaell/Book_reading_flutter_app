import 'package:bookreading/features/book/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/enums/orb_position.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widget/orb.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: Stack(
            children: [
              Orb(position: OrbPosition.topLeft),
              Orb(position: OrbPosition.centerRight, isCyan: false),
              Orb(position: OrbPosition.bottomLeft),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
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
      ],
    ),
  ];
}

import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static final homeRoute = GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const HomeScreen(),
  );

  // static final tabRoute1 = GoRoute(
  //   path: AppRoutes.screen2,
  //   builder: (context, state) => const Screen2(),
  // );
  // static final tabRoute2 = GoRoute(
  //   path: AppRoutes.screen3,
  //   builder: (context, state) => const Screen3(),
  // );
  // static final tabRoute = GoRoute(
  //   path: AppRoutes.screen4,
  //   builder: (context, state) => const Screen4(),
  // );
}

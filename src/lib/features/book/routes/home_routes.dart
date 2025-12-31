import 'package:bookreading/features/book/presentation/screens/home_page.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
  ];
}

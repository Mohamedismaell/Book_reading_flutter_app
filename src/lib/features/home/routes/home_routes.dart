import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/home/presentation/screens/home_page.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static final tabRoute = GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const HomePage(),
  );
}

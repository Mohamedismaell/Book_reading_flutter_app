import 'package:bookreading/core/navigaiton/tabs_shell.dart';
import 'package:bookreading/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:bookreading/core/shared/presentation/shell/app_shell.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/shared/routes/go_router_refresh_stream.dart';
import 'package:bookreading/features/book/routes/book_routes.dart';
import 'package:bookreading/features/explore/routes/explore_routes.dart';
import 'package:bookreading/features/home/routes/home_routes.dart';
import 'package:bookreading/features/library/routes/library_routes.dart';
import 'package:bookreading/features/profile/routes/profile_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/routes/auth_routes.dart';

class AppRouter {
  final AppGateCubit appGateCubit;
  AppRouter({required this.appGateCubit});

  late final GoRouter appRouter = GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: GoRouterRefreshStream(appGateCubit.stream),
    redirect: _redirect,
    routes: [
      // ...OnBoardingRoutes.routes,
      ...AuthRoutes.routes,
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(location: state.uri.toString(), child: child);
        },
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return TabsShell(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(routes: [HomeRoutes.homeRoute]),
              StatefulShellBranch(routes: [ExploreRoutes.routes]),
              StatefulShellBranch(routes: [LibraryRoutes.bookmarksRoute]),
              StatefulShellBranch(routes: [ProfileRoutes.routes]),
            ],
          ),
          ...BookRoutes.routes,
          ExploreRoutes.extraRoute,
          // ...CategoriesRoutes.extraRoutes,
          // ...PostDetailsRoutes.routes,
        ],
      ),
      // ...GeneraleRoutes.routes,
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final gateState = appGateCubit.state;
    final location = state.matchedLocation;
    // final isRecovering = authNotifier.isRecoveringPassword;

    switch (gateState) {
      //ToDo loading would be splash screen
      // case AppGateLoading():
      case AppGateOnboarding():
        if (location != AppRoutes.onBoarding) return AppRoutes.onBoarding;

      case AppGateAuthenticated():
        if (state.matchedLocation == AppRoutes.login) {
          return AppRoutes.home;
        }
        return null;

      case AppGateUnauthenticated():
        if (location != AppRoutes.login) {
          return AppRoutes.login;
        }

      default:
        return null;
    }
    return null;
  }
}
// final class AppGateLoading extends AppGateState {}

// final class AppGateOnboarding extends AppGateState {}

// final class AppGateSkipOnboarding extends AppGateState {}

// final class AppGateUnauthenticated extends AppGateState {}

// final class AppGateAuthenticated extends AppGateState {}
//! Error Screen
class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Something went wrong!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

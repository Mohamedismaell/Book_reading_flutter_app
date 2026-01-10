import 'package:bookreading/core/auth/auth_notifier.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/features/book/routes/home_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/routes/auth_routes.dart';
import '../di/service_locator.dart';

class AppRouter {
  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: sl<AuthNotifier>(),
    redirect: (context, state) {
      final authNotifier = sl<AuthNotifier>();
      final supabase = sl<SupabaseClient>();
      final user = supabase.auth.currentUser;
      final loggedIn = user != null;
      final isRecovering = authNotifier.isRecoveringPassword;

      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signUp;

      final isForgotRoute = state.matchedLocation == AppRoutes.forgotPassword;

      final isResetRoute = state.matchedLocation == AppRoutes.resetPassword;

      if (isRecovering && !isResetRoute) {
        return AppRoutes.resetPassword;
      }

      if (!loggedIn && !isAuthRoute && !isForgotRoute && !isResetRoute) {
        return AppRoutes.login;
      }

      if (loggedIn && isAuthRoute && !isRecovering) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [...AuthRoutes.routes, ...HomeRoutes.routes],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}

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

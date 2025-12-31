import 'package:bookreading/features/auth/presentation/screens/login_page.dart';
import 'package:bookreading/features/auth/presentation/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LogInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.redirect,
      builder: (context, state) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
  ];
}

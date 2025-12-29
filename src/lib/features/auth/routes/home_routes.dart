import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/auth/presentation/screens/login_page.dart';
import 'package:bookreading/features/auth/presentation/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routes/app_routes.dart';
import '../domain/usecases/login_google.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/sign_up_email.dart';

class AuthRoutes {
  static List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => AuthCubit(
            sl<LoginWithGoogle>(),
            sl<Logout>(),
            sl<SignUpWithEmail>(),
            sl<LoginWithEmail>(),
          ),
          child: Scaffold(body: child),
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LogInPage(),
        ),
        GoRoute(
          path: AppRoutes.signUp,
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
  ];
}

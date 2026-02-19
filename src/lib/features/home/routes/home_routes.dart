import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/all_books_cubit.dart';
import 'package:bookreading/features/home/presentation/screens/home_screen.dart';
import 'package:bookreading/features/progress/presentation/manager/reading_pregress/reading_progress_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static final homeRoute = GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<UserCubit>()..loadUser()),
        BlocProvider(create: (_) => sl<AllBooksCubit>()..loadBooks()),
        BlocProvider(create: (_) => sl<ReadingProgressCubit>()..getProgress()),
      ],
      child: const HomeScreen(),
    ),
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

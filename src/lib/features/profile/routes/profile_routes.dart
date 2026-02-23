import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/profile/profile_cubit.dart';
import 'package:bookreading/features/profile/presentation/manager/user_stats/user_stats_cubit.dart';
import 'package:bookreading/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileRoutes {
  static final routes = GoRoute(
    name: 'profile',
    path: AppRoutes.profile,

    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<UserCubit>()..loadUser()),
          BlocProvider(create: (_) => sl<ProfileCubit>()),
          BlocProvider(create: (_) => sl<UserStatsCubit>()..fetchUserStats()),
        ],
        child: ProfileScreen(),
      );
    },
  );
}

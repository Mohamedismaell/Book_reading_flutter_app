import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/explore/domain/usecases/search_usecase.dart';
import 'package:bookreading/features/explore/presentation/manager/comming_soon/comming_soon_cubit.dart';
import 'package:bookreading/features/explore/presentation/manager/popular_books/popular_books_cubit.dart';
import 'package:bookreading/features/explore/presentation/manager/search/search_cubit.dart';
import 'package:bookreading/features/explore/presentation/screens/explore_screen.dart';
import 'package:bookreading/features/explore/presentation/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExploreRoutes {
  static final routes = GoRoute(
    name: 'explore',
    path: AppRoutes.explore,

    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<PopularBooksCubit>()..fetchPopularBooks(),
          ),
          BlocProvider(
            create: (context) =>
                sl<CommingSoonCubit>()..fetchCommingSoonBooks(),
          ),
        ],
        child: ExploreScreen(),
      );
    },
  );

  static final extraRoute = GoRoute(
    name: 'search',
    path: AppRoutes.search,

    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SearchCubit(sl<SearchUseCase>(), sl<AppConnectionCubit>()),
          ),
        ],

        child: SearchScreen(),
      );
    },
  );
}

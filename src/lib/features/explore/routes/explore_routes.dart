import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/explore/domain/usecases/search_usecase.dart';
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
      // final bookId = int.parse(state.pathParameters['bookId']!);
      // final extra = state.extra as Map<String, dynamic>;
      return ExploreScreen(
        // bookId: bookId,
        // heroTag: extra['heroTag'],
        // coverUrl: extra['coverUrl'],
        // title: extra['title'],
        // author: extra['author'],
      );
    },
  );

  static final extraRoute = GoRoute(
    name: 'search',
    path: AppRoutes.search,

    builder: (context, state) {
      // final bookId = int.parse(state.pathParameters['bookId']!);

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

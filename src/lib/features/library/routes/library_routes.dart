import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:bookreading/features/library/presentation/screens/library_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LibraryRoutes {
  static final bookmarksRoute = GoRoute(
    path: AppRoutes.library,
    builder: (context, state) => BlocProvider(
      create: (context) => sl<LibraryCubit>(),
      child: const LibraryScreen(),
    ),
  );
}

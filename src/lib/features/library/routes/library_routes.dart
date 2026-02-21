import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/routes/app_routes.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:bookreading/features/library/presentation/screens/library_screen.dart';
import 'package:bookreading/features/progress/domain/usecases/get_finished_books.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LibraryRoutes {
  static final bookmarksRoute = GoRoute(
    path: AppRoutes.library,
    builder: (context, state) => BlocProvider(
      create: (context) =>
          LibraryCubit(sl<GetBookMarksBooks>(), sl<GetFinishedBooks>())
            ..fetchAllBookmarks(),
      child: const LibraryScreen(),
    ),
  );
}

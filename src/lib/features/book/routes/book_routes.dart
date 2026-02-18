import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/chapters_usecase.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_id_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/screens/book_details_screen.dart';
import 'package:bookreading/features/book/presentation/screens/chapter_reader_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared/routes/app_routes.dart';

class BookRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: AppRoutes.bookDetails,

      builder: (context, state) {
        final bookId = int.parse(state.pathParameters['bookId']!);
        final extra = state.extra as Map<String, dynamic>;
        return BookDetailsScreen(
          bookId: bookId,
          heroTag: extra['heroTag'],
          coverUrl: extra['coverUrl'],
          title: extra['title'],
          author: extra['author'],
        );
      },
    ),
    GoRoute(
      name: AppRoutes.read,
      path: AppRoutes.read,

      builder: (context, state) {
        final bookId = int.parse(state.pathParameters['bookId']!);

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BookIdCubit(sl<GetBookByIdUseCase>()),
            ),
            BlocProvider(
              create: (context) => ChaptersCubit(sl<GetChaptersUseCase>()),
            ),
          ],

          child: ChapterReaderScreen(bookId: bookId),
        );
      },
    ),
  ];
}

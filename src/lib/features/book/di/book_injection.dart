import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book/data/datasources/books_remote_data_source.dart';
import 'package:bookreading/features/book/data/repositories/book_repository_impl.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/books_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookDi {
  BookDi._();

  static void init() {
    // //! Data Sources
    // sl.registerLazySingleton<BooksLocalDataSource>(
    //   () => BooksLocalDataSourceImpl(),
    // );

    sl.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSource(supabaseCilent: sl<SupabaseClient>()),
    );

    //! Repositories
    sl.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(
        // localDataSource: sl<LocalDataSource>(),
        remoteDataSource: sl<BookRemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<GetBooksUseCase>(
      () => GetBooksUseCase(repository: sl<BookRepository>()),
    );

    //! Cubit / Manager
    sl.registerLazySingleton<AllBooksCubit>(
      () => AllBooksCubit(sl<GetBooksUseCase>()),
    );
  }
}

import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks_id.dart';
import 'package:bookreading/features/book_marks/domain/usecases/insert_book_marks.dart';
import 'package:bookreading/features/book_marks/presentation/manager/book_marks/book_marks_cubit.dart';
import 'package:bookreading/features/book_marks/data/datasources/book_marks_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Data sources
import '../data/datasources/book_marks_local_data_source.dart';
import '../data/datasources/book_marks_remote_data_source.dart';

// Repository
import '../data/repositories/book_marks_repository_impl.dart';
import '../domain/repositories/book_marks_repository.dart';

// Use cases
import '../domain/usecases/remove_book_marks.dart';

// Presentation (Cubit / Manager)

class BookMarksDi {
  BookMarksDi._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<BookMarksLocalDataSource>(
      () => BookMarksLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<BookMarksRemoteDataSource>(
      () => BookMarksRemoteDataSource(supabaseClient: sl<SupabaseClient>()),
    );

    //! Repositories
    sl.registerLazySingleton<BookMarksRepository>(
      () => BookMarksRepositoryImpl(
        localDataSource: sl<BookMarksLocalDataSource>(),
        remoteDataSource: sl<BookMarksRemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<InsertBookMarks>(
      () => InsertBookMarks(repository: sl<BookMarksRepository>()),
    );
    sl.registerLazySingleton<RemoveBookMarks>(
      () => RemoveBookMarks(repository: sl<BookMarksRepository>()),
    );
    sl.registerLazySingleton<GetBookMarksBooks>(
      () => GetBookMarksBooks(repository: sl<BookMarksRepository>()),
    );
    sl.registerLazySingleton<GetBookMarksId>(
      () => GetBookMarksId(repository: sl<BookMarksRepository>()),
    );

    //! Cubit / Manager
    sl.registerLazySingleton<BookMarksCubit>(
      () => BookMarksCubit(
        sl<InsertBookMarks>(),
        sl<RemoveBookMarks>(),
        sl<GetBookMarksId>(),
      ),
    );
  }
}

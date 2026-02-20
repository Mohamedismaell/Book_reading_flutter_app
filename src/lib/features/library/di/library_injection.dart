import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks.dart';
import 'package:bookreading/features/library/presentation/manager/Library_cubit/library_cubit.dart';
import 'package:bookreading/features/progress/domain/usecases/get_finished_books.dart';

class LibraryDi {
  LibraryDi._();

  static void init() {
    // //! Data Sources
    // sl.registerLazySingleton<LibraryLocalDataSource>(
    //   () => LibraryLocalDataSourceImpl(),
    // );

    // sl.registerLazySingleton<LibraryRemoteDataSource>(
    //   () => LibraryRemoteDataSource(),
    // );

    // //! Repositories
    // sl.registerLazySingleton<LibraryRepository>(
    //   () => LibraryRepositoryImpl(
    //     localDataSource: sl<LibraryLocalDataSource>(),
    //     remoteDataSource: sl<LibraryRemoteDataSource>(),
    //   ),
    // );

    //! Use Cases

    //! Cubit / Manager
    sl.registerLazySingleton<LibraryCubit>(
      () => LibraryCubit(sl<GetBookMarksBooks>(), sl<GetFinishedBooks>()),
    );
  }
}

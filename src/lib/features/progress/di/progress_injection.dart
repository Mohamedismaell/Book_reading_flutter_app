import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/progress/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/progress/data/datasources/progress_data_source.dart';
import 'package:bookreading/features/progress/domain/usecases/save_reading_pregress.dart';
import 'package:bookreading/features/progress/presentation/manager/reading_pregress/reading_progress_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Data sources
import '../data/datasources/progress_local_data_source.dart';
import '../data/datasources/progress_remote_data_source.dart';
// Repository
import '../data/repositories/progress_repository_impl.dart';
import '../domain/repositories/progress_repository.dart';

// Presentation (Cubit / Manager)

class ProgressDi {
  ProgressDi._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<ProgressLocalDataSource>(
      () => ProgressLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<ProgressRemoteDataSource>(
      () => ProgressRemoteDataSource(supabaseCilent: sl<SupabaseClient>()),
    );

    //! Repositories
    sl.registerLazySingleton<ProgressRepository>(
      () => ProgressRepositoryImpl(
        // localDataSource: sl<ProgressLocalDataSource>(),
        remoteDataSource: sl<ProgressRemoteDataSource>(),
      ),
    );

    //! Use Cases
    // sl.registerLazySingleton<ProgressUseCase>(
    //   () => ProgressUseCase(sl<ProgressRepository>()),
    // );
    sl.registerLazySingleton<SaveReadingPregress>(
      () => SaveReadingPregress(repository: sl<ProgressRepository>()),
    );
    sl.registerLazySingleton<GetReadingProgress>(
      () => GetReadingProgress(repository: sl<ProgressRepository>()),
    );
    //! Cubit / Manager
    sl.registerLazySingleton<ReadingProgressCubit>(
      () => ReadingProgressCubit(
        sl<SaveReadingPregress>(),
        sl<GetReadingProgress>(),
      ),
    );
  }
}

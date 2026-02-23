import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/profile/data/datasources/profile_data_source.dart';
import 'package:bookreading/features/profile/domain/usecases/get_user_stats.dart';
import 'package:bookreading/features/profile/presentation/manager/user_stats/user_stats_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Data sources
import '../data/datasources/profile_local_data_source.dart';
import '../data/datasources/profile_remote_data_source.dart';

// Repository
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';

// Use cases
import '../domain/usecases/profile_usecase.dart';

// Presentation (Cubit / Manager)

class ProfileDi {
  ProfileDi._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(supabaseCilent: sl<SupabaseClient>()),
    );

    //! Repositories
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        localDataSource: sl<ProfileLocalDataSource>(),
        remoteDataSource: sl<ProfileRemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(
        // sl<ProfileRepository>(),
      ),
    );
    sl.registerLazySingleton<GetUserStats>(
      () => GetUserStats(repository: sl<ProfileRepository>()),
    );

    //! Cubit / Manager
    // sl.registerLazySingleton<ProfileCubit>(
    //   () => ProfileCubit(
    //     sl<ProfileUseCase>(),
    //   ),
    // );
    sl.registerFactory<UserStatsCubit>(
      () => UserStatsCubit(sl<GetUserStats>()),
    );
  }
}

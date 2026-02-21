import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:bookreading/features/explore/data/datasources/explore_data_source.dart';
import 'package:bookreading/features/explore/presentation/manager/search/search_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Data sources
import '../data/datasources/explore_local_data_source.dart';
import '../data/datasources/explore_remote_data_source.dart';

// Repository
import '../data/repositories/explore_repository_impl.dart';
import '../domain/repositories/explore_repository.dart';

// Use cases
import '../domain/usecases/search_usecase.dart';

// Presentation (Cubit / Manager)

class ExploreDi {
  ExploreDi._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<ExploreLocalDataSource>(
      () => ExploreLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<ExploreRemoteDataSource>(
      () => ExploreRemoteDataSource(supabaseClient: sl<SupabaseClient>()),
    );

    //! Repositories
    sl.registerLazySingleton<ExploreRepository>(
      () => ExploreRepositoryImpl(
        localDataSource: sl<ExploreLocalDataSource>(),
        remoteDataSource: sl<ExploreRemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<SearchUseCase>(
      () => SearchUseCase(exploreRepository: sl<ExploreRepository>()),
    );

    //! Cubit / Manager
    sl.registerLazySingleton<SearchCubit>(
      () => SearchCubit(sl<SearchUseCase>(), sl<AppConnectionCubit>()),
    );
  }
}

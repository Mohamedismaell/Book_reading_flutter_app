import 'package:bookreading/core/database/api/dio_consumer.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:bookreading/features/home/data/datasources/home_data_source.dart';
import 'package:bookreading/features/home/presentation/manager/home/home_cubit.dart';

// Data sources
import '../data/datasources/home_local_data_source.dart';
import '../data/datasources/home_remote_data_source.dart';

// Repository
import '../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';

// Use cases
import '../domain/usecases/home_usecase.dart';

// Presentation (Cubit / Manager)

class HomeDi {
  HomeDi._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(),
    );

    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSource(api: sl<DioConsumer>()),
    );

    //! Repositories
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        localDataSource: sl<HomeLocalDataSource>(),
        remoteDataSource: sl<HomeRemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(
        // sl<HomeRepository>(),
      ),
    );

    //! Cubit / Manager
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl<GetCurrentUser>()));
  }
}

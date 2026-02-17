import 'package:bookreading/core/shared/injection/service_locator.dart';

// Data sources
import '../data/datasources/{{name.snakeCase()}}_local_data_source.dart';
import '../data/datasources/{{name.snakeCase()}}_remote_data_source.dart';

// Repository
import '../data/repositories/{{name.snakeCase()}}_repository_impl.dart';
import '../domain/repositories/{{name.snakeCase()}}_repository.dart';

// Use cases
import '../domain/usecases/{{name.snakeCase()}}_usecase.dart';

// Presentation (Cubit / Manager)
import '../presentation/manager/{{name.snakeCase()}}_cubit.dart';

class {{name.pascalCase()}}Di {
  {{name.pascalCase()}}Di._();

  static void init() {
    //! Data Sources
    sl.registerLazySingleton<{{name.pascalCase()}}LocalDataSource>(
      () => {{name.pascalCase()}}LocalDataSourceImpl(),
    );

    sl.registerLazySingleton<{{name.pascalCase()}}RemoteDataSource>(
      () => {{name.pascalCase()}}RemoteDataSource(api: sl<DioConsumer>()),
    );

    //! Repositories
    sl.registerLazySingleton<{{name.pascalCase()}}Repository>(
      () => {{name.pascalCase()}}RepositoryImpl(
        localDataSource: sl<{{name.pascalCase()}}LocalDataSource>(),
        remoteDataSource: sl<{{name.pascalCase()}}RemoteDataSource>(),
      ),
    );

    //! Use Cases
    sl.registerLazySingleton<{{name.pascalCase()}}UseCase>(
      () => {{name.pascalCase()}}UseCase(
        sl<{{name.pascalCase()}}Repository>(),
      ),
    );

    //! Cubit / Manager
    sl.registerLazySingleton<{{name.pascalCase()}}Cubit>(
      () => {{name.pascalCase()}}Cubit(
        sl<{{name.pascalCase()}}UseCase>(),
      ),
    );
  }
}

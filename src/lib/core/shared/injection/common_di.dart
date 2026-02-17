import 'package:bookreading/core/connections/network_info.dart';
import 'package:bookreading/core/connections/retry_queue.dart';
import 'package:bookreading/core/connections/retry_runner.dart';
import 'package:bookreading/core/database/api/api_interceptor.dart';
import 'package:bookreading/core/database/api/dio_consumer.dart';
import 'package:bookreading/core/database/cache/cache_helper.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:bookreading/core/shared/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

CacheHelper get cacheHelper => sl<CacheHelper>();

class CommonDi {
  CommonDi._();

  static Future<void> init() async {
    sl.registerLazySingleton(() => ThemeCubit());
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => InternetConnection());

    //! Core
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnection>()),
    );
    sl.registerLazySingleton(() => RetryQueue());
    sl.registerLazySingleton(() => RetryRunner(sl<Dio>(), sl<RetryQueue>()));

    sl.registerLazySingleton(
      () => ApiInterceptor(sl<NetworkInfo>(), sl<RetryQueue>()),
    );
    sl.registerLazySingleton(
      () => DioConsumer(sl<Dio>(), sl<ApiInterceptor>()),
    );
    sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

    //! connection

    // //! Validators
    // sl.registerLazySingleton(() => FormValidators());
    // sl.registerLazySingleton(() => UserValidation());
    // //! Data Sources
    // sl.registerLazySingleton<NewsRemoteDataSource>(
    //   () => NewsRemoteDataSource(api: sl<DioConsumer>()),
    // );
    // sl.registerLazySingleton<NewsLocalDataSource>(
    //   () => NewsLocalDataSource(newsBox: newsBox),
    // );
    // //! Repositories
    // sl.registerLazySingleton<NewsRepository>(
    //   () => NewsRepositoryImpl(
    //     remoteDataSource: sl<NewsRemoteDataSource>(),
    //     localDataSource: sl<NewsLocalDataSource>(),
    //   ),
    // ); //! Use Cases
    // sl.registerLazySingleton(
    //   () => GetNewsByCategory(repository: sl<NewsRepository>()),
    // );
    //! Local Storage
    final cacheHelper = CacheHelper();
    await cacheHelper.init();
    sl.registerSingleton<CacheHelper>(cacheHelper);

    //!Cubits
    sl.registerLazySingleton(
      () => AppConnectionCubit(sl<InternetConnection>(), sl<RetryRunner>()),
    );
  }
}

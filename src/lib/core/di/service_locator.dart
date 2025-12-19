import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/features/auth/domain/usecases/otp.dart';
import 'package:bookreading/features/auth/domain/usecases/signup.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/news_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forget_password.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../connections/network_info.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache/cache_helper.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  //! Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioConsumer(dio: sl<Dio>()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl<DataConnectionChecker>()),
  );
  sl.registerLazySingleton(() => CacheHelper());

  //! Data Sources
  // sl.registerLazySingleton<NewsRemoteDataSource>(
  //   () => NewsRemoteDataSource(api: sl<DioConsumer>()),
  // );

  // //! Repositories
  // sl.registerLazySingleton<NewsRepository>(
  //   () => NewsRepositoryImpl(
  //     remoteDataSource: sl<NewsRemoteDataSource>(),
  //     networkInfo: sl<NetworkInfo>(),
  //   ),
  // );
  //! Supabase
  // sl.registerLazySingleton(() => Supabase.instance.client);

  //! Use Cases
  sl.registerLazySingleton(() => Login(repository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => Signup(repository: sl<AuthRepository>()));
  sl.registerLazySingleton(() => Otp(repository: sl<AuthRepository>()));
  sl.registerLazySingleton(
    () => ForgetPassword(repository: sl<AuthRepository>()),
  );

  //! Cubits
  //TODO Register ==> "AuthCubit" later
  sl.registerLazySingleton(() => ThemeCubit());
}

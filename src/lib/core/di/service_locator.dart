import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/otp.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_google.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/presentation/cubit/cubit/auth_cubit.dart';
import '../auth/auth_notifier.dart';
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
  sl.registerLazySingleton(() => AuthNotifier());

  //! Register SupabaseClient
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  //! Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(supabase: sl<SupabaseClient>()),
  );

  //! Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  //! Use Cases
  sl.registerLazySingleton(
    () => LoginWithGoogle(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton(
    () => SignUpWithEmail(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton(
    () => LoginWithEmail(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton(() => Otp(repository: sl<AuthRepository>()));
  // sl.registerLazySingleton(
  //   () => ForgetPassword(repository: sl<AuthRepository>()),
  // );
  // sl.registerLazySingleton(
  //   () => UpdatePassword(repository: sl<AuthRepository>()),
  // );
  sl.registerLazySingleton(() => Logout(repository: sl<AuthRepository>()));

  //! Cubits
  //TODO Register ==> "AuthCubit" later
  sl.registerLazySingleton(
    () => AuthCubit(
      sl<LoginWithGoogle>(),
      sl<Logout>(),
      sl<SignUpWithEmail>(),
      sl<LoginWithEmail>(),
      // sl<ForgetPassword>(),
      // sl<UpdatePassword>(),
    ),
  );
  sl.registerLazySingleton(() => ThemeCubit());
}

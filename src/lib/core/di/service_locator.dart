import 'package:bookreading/core/theme/cubit/theme_cubit.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/otp.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:bookreading/features/auth/domain/usecases/update_passwords.dart';
import 'package:bookreading/features/book/data/datasources/books_remote_data_source.dart';
import 'package:bookreading/features/book/data/repositories/book_repository_impl.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';
import 'package:bookreading/features/book/domain/usecases/get_book_by_id.dart';
import 'package:bookreading/features/book/domain/usecases/get_books_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/get_chapters_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/book/domain/usecases/get_user_stats.dart';
import 'package:bookreading/features/book/domain/usecases/insert_reading_pregress.dart';
import 'package:bookreading/features/book/domain/usecases/update_user_stats.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/books_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/profile/user_stats_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forget_password.dart';
import '../../features/auth/domain/usecases/login_google.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/presentation/cubit/cubit/auth_cubit.dart';
import '../auth/auth_notifier.dart';
import '../connections/network_info.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache/cache_helper.dart';

import 'package:flutter/foundation.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  //! Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioConsumer(dio: sl<Dio>()));
  if (!kIsWeb) {
    sl.registerLazySingleton(() => DataConnectionChecker());
  }
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: kIsWeb ? null : sl<DataConnectionChecker>(),
    ),
  );
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => AuthNotifier());

  //! Register SupabaseClient
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  // sl.registerLazySingleton<User>(() => sl<SupabaseClient>().auth.currentUser!);
  //! Data Sources
  //* Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(supabase: sl<SupabaseClient>()),
  );
  //* Books
  sl.registerLazySingleton<BooksRemoteDataSource>(
    () => BooksRemoteDataSource(supabase: sl<SupabaseClient>()),
  );
  //! Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      remoteDataSource: sl<BooksRemoteDataSource>(),
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
  sl.registerLazySingleton(
    () => ForgetPassword(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton(
    () => UpdatePassword(repository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton(() => Logout(repository: sl<AuthRepository>()));
  //* Books
  sl.registerLazySingleton(
    () => GetBooksUseCase(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => GetChaptersUseCase(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => GetBooksIdUseCase(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => InsertReadingPregress(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => GetReadingProgress(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => UpdateUserStats(repository: sl<BookRepository>()),
  );
  sl.registerLazySingleton(
    () => GetUserStats(repository: sl<BookRepository>()),
  );
  //! Cubits
  sl.registerLazySingleton(
    () => AuthCubit(
      sl<LoginWithGoogle>(),
      sl<Logout>(),
      sl<SignUpWithEmail>(),
      sl<LoginWithEmail>(),
      sl<ForgetPassword>(),
      sl<UpdatePassword>(),
    ),
  );
  sl.registerLazySingleton(() => BooksCubit(sl<GetBooksUseCase>()));
  sl.registerLazySingleton(() => BookCubit(sl<GetBooksIdUseCase>()));

  sl.registerLazySingleton(() => ChaptersCubit(sl<GetChaptersUseCase>()));
  sl.registerLazySingleton(
    () => ReadingProgressCubit(
      sl<InsertReadingPregress>(),
      sl<GetReadingProgress>(),
    ),
  );
  sl.registerLazySingleton(
    () => UserStatsCubit(sl<UpdateUserStats>(), sl<GetUserStats>()),
  );

  sl.registerLazySingleton(() => ThemeCubit());
}

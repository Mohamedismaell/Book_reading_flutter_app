import 'package:bookreading/core/connections/network_info.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookreading/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:bookreading/features/auth/domain/repositories/auth_repository.dart';
import 'package:bookreading/features/auth/domain/usecases/forget_password.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:bookreading/features/auth/domain/usecases/otp.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:bookreading/features/auth/domain/usecases/update_passwords.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDi {
  AuthDi._();

  static void init() {
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
    sl.registerLazySingleton(
      () => ForgetPassword(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(
      () => UpdatePassword(repository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton(() => Logout(repository: sl<AuthRepository>()));
    //!Cubit
    sl.registerLazySingleton(
      () => AuthCubit(
        google: sl<LoginWithGoogle>(),
        userLogout: sl<Logout>(),
        signUpEmail: sl<SignUpWithEmail>(),
        logInEmail: sl<LoginWithEmail>(),
        resetPassword: sl<ForgetPassword>(),
        updatePassword: sl<UpdatePassword>(),
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
  }
}

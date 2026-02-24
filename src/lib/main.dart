import 'package:bookreading/core/connections/retry_runner.dart';
import 'package:bookreading/core/database/cache/app_hive.dart';
import 'package:bookreading/core/helper/hydrated_storage.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:bookreading/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:bookreading/core/shared/routes/app_router.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:bookreading/features/auth/domain/usecases/update_passwords.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/onboarding/domain/repositories/auth_repository.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/observers/app_bloc_observer.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/theme_data/dark_theme_data.dart';
import 'core/theme/theme_data/light_theme_data.dart';
import 'features/auth/domain/usecases/forget_password.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Step 1: ensureInitialized done');
  Bloc.observer = AppBlocObserver();
  print('Step 2: Bloc observer set');
  HydratedBloc.storage = await buildHydratedStorage();
  print('Step 3: HydratedStorage built');
  await AppHive.init();
  await initializeDependencies(onboardingBox: AppHive.onboardingBox);
  print('Step 4: Service Locator initialized');
  await Supabase.initialize(
    url: 'https://iszsxfqfmsjotmdnszyi.supabase.co',
    anonKey: 'sb_publishable_yNt2YfuCVSrFuS53esNU4A_HtIhv9j0',
  );
  print('Step 5: Supabase initialized');

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    // DevicePreview(enabled: !kReleaseMode, builder: (context) => AppBootstrap()),
    AppBootstrap(),
  );
}

//!providers
class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppConnectionCubit>(
          create: (_) =>
              AppConnectionCubit(sl<InternetConnection>(), sl<RetryRunner>()),
        ),
        BlocProvider<AppGateCubit>(
          create: (_) => AppGateCubit(
            onboardingRepository: sl<OnboardingRepository>(),
            client: sl<SupabaseClient>(),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            google: sl<LoginWithGoogle>(),
            userLogout: sl<Logout>(),
            signUpEmail: sl<SignUpWithEmail>(),
            logInEmail: sl<LoginWithEmail>(),
            resetPassword: sl<ForgetPassword>(),
            updatePassword: sl<UpdatePassword>(),
            supabaseClient: sl<SupabaseClient>(),
          ),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),

        // BlocProvider<BooksCubit>(
        //   create: (context) => BooksCubit(sl<GetBooksUseCase>()),
        // ),
        // BlocProvider<BookCubit>(
        //   create: (context) => BookCubit(sl<GetBooksIdUseCase>()),
        // ),
        // BlocProvider<ChaptersCubit>(
        //   create: (context) => ChaptersCubit(sl<GetChaptersUseCase>()),
        // ),
        // BlocProvider<ReadingProgressCubit>(
        //   create: (context) => ReadingProgressCubit(
        //     sl<InsertReadingPregress>(),
        //     sl<GetReadingProgress>(),
        //   ),
        // ),
        // BlocProvider<UserStatsCubit>(
        //   create: (context) =>
        //       UserStatsCubit(sl<UpdateUserStats>(), sl<GetUserStats>()),
        // ),
        // BlocProvider<ProfileCubit>(
        //   create: (context) => ProfileCubit(
        //     sl<GetUserProfile>(),
        //     sl<UpdateUserProfile>(),
        //     sl<UploadAvatar>(),
        //     // sl<GetAvatar>(),
        //   ),
        // ),
        // BlocProvider<BookMarksCubit>(
        //   create: (context) => BookMarksCubit(
        //     sl<InsertBookMarks>(),
        //     sl<RemoveBookMarks>(),
        //     sl<GetBookMarks>(),
        //   ),
        // ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(
    //     "USER EMAIL ===> **** ${sl<SupabaseClient>().auth.currentUser?.email} ****",
    //   );
    // }
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, mode) {
        return ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp.router(
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(),
            darkTheme: getDarkTheme(),
            themeMode: mode.themeMode,
            routerConfig: sl<AppRouter>().appRouter,
            builder: DevicePreview.appBuilder,
          ),
        );
      },
    );
  }
}

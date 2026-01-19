import 'package:bookreading/core/helper/hydrated_storage.dart';
import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_router.dart';
import 'package:bookreading/features/auth/domain/usecases/login_email.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import 'package:bookreading/features/auth/domain/usecases/logout.dart';
import 'package:bookreading/features/auth/domain/usecases/sign_up_email.dart';
import 'package:bookreading/features/auth/domain/usecases/update_passwords.dart';
import 'package:bookreading/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:bookreading/features/book/domain/usecases/get_book_by_id.dart';
import 'package:bookreading/features/book/domain/usecases/get_books_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/get_chapters_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/insert_reading_pregress.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/books_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/book_id/book_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/reading_pregress/reading_progress_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/observers/app_bloc_observer.dart';
import 'core/di/service_locator.dart';
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
  await initServiceLocator();
  print('Step 4: Service Locator initialized');
  await Supabase.initialize(
    url: 'https://iszsxfqfmsjotmdnszyi.supabase.co',
    anonKey: 'sb_publishable_yNt2YfuCVSrFuS53esNU4A_HtIhv9j0',
  );
  print('Step 5: Supabase initialized');

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => AppBootstrap(), // Wrap your app
    // ),
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
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            sl<LoginWithGoogle>(),
            sl<Logout>(),
            sl<SignUpWithEmail>(),
            sl<LoginWithEmail>(),
            sl<ForgetPassword>(),
            sl<UpdatePassword>(),
          ),
        ),
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<BooksCubit>(
          create: (context) => BooksCubit(sl<GetBooksUseCase>()),
        ),
        BlocProvider<BookCubit>(
          create: (context) => BookCubit(sl<GetBooksIdUseCase>()),
        ),
        BlocProvider<ChaptersCubit>(
          create: (context) => ChaptersCubit(sl<GetChaptersUseCase>()),
        ),
        BlocProvider<ReadingProgressCubit>(
          create: (context) =>
              ReadingProgressCubit(sl<InsertReadingPregress>()),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(
        "USER EMAIL ===> **** ${sl<SupabaseClient>().auth.currentUser?.email} ****",
      );
    }
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, mode) {
        return SizeProvider(
          baseSize: const Size(428, 926),
          height: context.screenHeight,
          width: context.screenWidth,
          child: MaterialApp.router(
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(),
            darkTheme: getDarkTheme(),
            themeMode: mode.themeMode,
            routerConfig: AppRouter.router,
            builder: DevicePreview.appBuilder,
          ),
        );
      },
    );
  }
}

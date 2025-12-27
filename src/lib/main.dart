import 'package:bookreading/core/theme/theme_data/dark_theme_data.dart';
import 'package:bookreading/features/auth/presentation/screens/login_page.dart';
import 'package:bookreading/features/auth/presentation/screens/test_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/observers/app_bloc_observer.dart';
import 'core/di/service_locator.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/theme/theme_data/light_theme_data.dart';
import 'package:path_provider/path_provider.dart';
// import 'core/theme/theme_data/dark_theme_data.dart';
// import 'core/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await initServiceLocator();
  await Supabase.initialize(
    url: 'https://iszsxfqfmsjotmdnszyi.supabase.co',
    anonKey: 'sb_publishable_yNt2YfuCVSrFuS53esNU4A_HtIhv9j0',
  );

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(), // Wrap your app
    // ),
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(390, 884),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                // locale: DevicePreview.locale(context),
                // builder: DevicePreview.appBuilder,
                theme: getLightTheme(),
                themeMode: ThemeMode.dark,
                home: HomeScreen(),
              );
            },
          );

          // )
          // MaterialApp.router(
          //   // debugShowCheckedModeBanner: false,
          //   theme: getLightTheme(),
          //   // darkTheme: getDarkTheme(),
          //   themeMode: state.themeMode,
          //   // routerConfig: AppRouter.router,
          // );
        },
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: router,
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//     );
//   }

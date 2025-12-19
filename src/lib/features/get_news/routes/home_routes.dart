// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/di/service_locator.dart';
// import '../presentation/screens/home_screen.dart';

// class HomeRoutes {
//   static List<RouteBase> routes = [
//     ShellRoute(
//       builder: (context, state, child) {
//         return BlocProvider.value(
//           value: sl<NewsCubit>()..init(),
//           child: Scaffold(
//             body: child,
//             bottomNavigationBar: HomeNavigationBar(
//               currentLocation: state.matchedLocation,
//             ),
//           ),
//         );
//       },
//       routes: [
//         GoRoute(path: AppRoutes.home, builder: (_, __) => const HomeScreen()),
//         GoRoute(
//           path: AppRoutes.categories,
//           builder: (_, __) => const CategoriesScreen(),
//         ),
//         GoRoute(
//           path: AppRoutes.bookmarks,
//           builder: (_, __) => const BookMarksScreen(),
//         ),
//         GoRoute(
//           path: AppRoutes.categoryScreen,
//           builder: (context, state) {
//             //Todo: Edit cateogry passing type here.
//             final category = state.extra as NewsCategory;
//             context.read<NewsCubit>().eitherFailureOrSuccessByCategory(
//               category.value,
//             );

//             return CategoryScreen(category: category);
//           },
//         ),
//       ],
//     ),
//     GoRoute(
//       path: AppRoutes.newsDetails,
//       builder: (context, state) {
//         final argu = state.extra as NewsDetailsArgs;

//         return PostDetails(category: argu.category, post: argu.post);
//       },
//     ),
//   ];
// }

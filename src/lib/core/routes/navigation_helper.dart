// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';
// import '../../features/templete/presentation/cubit/news/news_cubit.dart';
// import '../../features/templete/presentation/model/news_detail_args.dart';
// import 'app_routes.dart';

// /// Navigation helper class to handle all navigation operations
// class NavigationHelper {
//   /// Navigate to splash screen
//   // static void goToHome(BuildContext context) {
//   //   context.go(AppRoutes.home);
//   // }

//   // static void goToCategories(BuildContext context) {
//   //   context.go(AppRoutes.category);
//   // }

//   // static void goToBookmarkes(BuildContext context) {
//   //   context.go(AppRoutes.bookmarks);
//   // }

//   // static Future<Object?> goToPostDetails(
//   //     BuildContext context, NewsState state, int index) {
//   //   return context.push(
//   //     AppRoutes.newsDetails,
//   //     extra: NewsDetailsArgs(
//   //         post: state.newsByCategory![index],
//   //         category: state
//   //             .newsByCategory![index].categories.first),
//   //   );
//   // }

//   /// Navigate to onboarding screens

//   //! Go back to previous screen
//   static void goBack(BuildContext context) {
//     if (context.canPop()) {
//       context.pop();
//     }
//   }

//   // /// Push a new screen on the stack
//   // static void pushTo(BuildContext context, String route) {
//   //   context.push(route);
//   // }

//   // /// Navigate with parameters
//   // static void goWithParams(
//   //   BuildContext context,
//   //   String route,
//   //   Map<String, String> params,
//   // ) {
//   //   final uri = Uri(path: route, queryParameters: params);
//   //   context.go(uri.toString());
//   // }

//   // /// Push with parameters
//   // static void pushWithParams(
//   //   BuildContext context,
//   //   String route,
//   //   Map<String, String> params,
//   // ) {
//   //   final uri = Uri(path: route, queryParameters: params);
//   //   context.push(uri.toString());
//   // }
// }

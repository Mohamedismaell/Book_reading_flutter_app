// import 'package:bookreading/core/theme/extensions/theme_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../core/shared/routes/app_routes.dart';

// class BooksGrid extends StatelessWidget {
//   const BooksGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> categories = [
//       "All",
//       "Fiction",
//       "Non-Fiction",
//       "Science",
//     ];
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: categories.length,
//       itemBuilder: (context, index) => _Content(index: index),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.w,
//         mainAxisSpacing: 16.h,
//         childAspectRatio: 0.52,
//         // childAspectRatio: 0.5,
//       ),
//     );
//   }
// }

// class _Content extends StatelessWidget {
//   const _Content({required this.index});
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => context.push(AppRoutes.bookDetails),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AspectRatio(
//             aspectRatio: 160 / 250,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.r),
//               child: Image.asset(
//                 'assets/images/back_ground_auth.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(height: 8.h),
//           //!Text
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Book Title",
//                   style: context.textTheme.headlineSmall,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2.h),
//                 Text(
//                   "Book Author",
//                   style: context.textTheme.bodyMedium,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/books.dart';
import 'package:bookreading/features/book/presentation/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/category_button.dart';
import '../widget/continue_reading.dart';
import '../widget/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //! Header
        const Header(),
        SizedBox(height: 16.h),
        //! Search
        const Search(),
        SizedBox(height: 16.h),
        //! Button
        const CategoryButton(),
        SizedBox(height: 35.h),
        //! Continue Reading
        Stack(children: [const ContinueReading()]),
        SizedBox(height: 32.h),
        //! Books
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.only(left: 6.0.w),
              child: Text("For you", style: context.textTheme.headlineMedium),
            ),
            SizedBox(height: 16.h),
            const BooksGrid(),
          ],
        ),
      ],
    );
  }
}

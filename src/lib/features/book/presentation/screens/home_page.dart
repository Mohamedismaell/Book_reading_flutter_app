import 'package:bookreading/features/book/presentation/widget/books.dart';
import 'package:bookreading/features/book/presentation/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/category_button.dart';
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
        //! Books
        const Books(),
      ],
    );
  }
}

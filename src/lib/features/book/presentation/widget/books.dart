import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "All",
      "Fiction",
      "Non-Fiction",
      "Science",
      "History",
      "Science",
      "History",
      "Science",
      "History",
    ];
    return SizedBox(
      height: 308.h,
      child: ListView.builder(
        // padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: _Content(),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20.r),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 160.w,
            height: 250.h,
            child: Image.asset('assets/images/book.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}

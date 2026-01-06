import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  int selectedIndex = 0;
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
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(right: 30.w),
          child: _Content(
            index: index,
            categories: categories,
            isSeleceted: selectedIndex == index,
            onTap: () => setState(() {
              selectedIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.index,
    required this.categories,
    required this.isSeleceted,
    required this.onTap,
  });

  final int index;
  final List<String> categories;
  final bool isSeleceted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(categories[index], style: context.textTheme.bodyMedium),
          SizedBox(height: isSeleceted ? 6.h : 0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isSeleceted ? 2.h : 0,
            width: isSeleceted ? 20.w : 0,
            decoration: BoxDecoration(
              color: context.colorTheme.primary,
              borderRadius: BorderRadius.circular(60.r),
            ),
          ),
        ],
      ),
    );
  }
}

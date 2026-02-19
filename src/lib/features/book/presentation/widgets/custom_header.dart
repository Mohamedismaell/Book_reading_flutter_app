import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    this.author,
    required this.bookId,
    required this.isheader,
    this.title,
  });
  final int bookId;
  final String? title;
  final String? author;
  final bool isheader;

  @override
  Widget build(BuildContext context) {
    //Todo fix theme
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => context.canPop() ? context.pop() : null,
          color: context.colorTheme.onSurface,
          icon: Icon(Icons.arrow_back, size: 26.r),
        ),
        // Spacer(),
        isheader
            ? Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineMedium!.copyWith(
                          color: context.colorTheme.onSurface.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        author!,
                        style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            );
            return ScaleTransition(scale: curved, child: child);
          },
          child: Icon(
            Icons.bookmark,

            size: 32.r,
            color: context.colorTheme.primary,
          ),
        ),
      ],
    );
  }
}

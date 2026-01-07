import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:bookreading/features/book/presentation/widget/star_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(),
        Expanded(child: _BookCover()),
        // SizedBox(height: 35.h),
        _BookOverview(
          title: 'About the author',
          description:
              'J.D. Salinger was an American writer, best known for his 1951 novel The Catcher in the Rye. Before its publi cation, Salinger published several short stories in Story magazine',
        ),
        SizedBox(height: 18.h),
        _BookOverview(
          title: 'Overview',
          description:
              'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adu lts but is often read by adolescents for its theme of angst, alienation and as a critique......',
        ),
        SizedBox(height: 20.h),
        _Buttons(),
        SizedBox(height: 25.h),
      ],
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: SizedBox(
            width: 180.w,
            height: 310.h,
            child: Image.asset('assets/images/dune.png', fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 6.h),
        Text('Book title', style: context.textTheme.headlineSmall),
        SizedBox(height: 6.h),
        Text('Book author', style: context.textTheme.bodyMedium),
        SizedBox(height: 6.h),
        const Star(),
      ],
    );
  }
}

class _BookOverview extends StatelessWidget {
  const _BookOverview({required this.title, required this.description});

  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.labelLarge),
        SizedBox(height: 6.h),
        Text(
          description,
          style: context.textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("button 1", style: context.textTheme.labelSmall),
        ),
        SizedBox(width: 20.w),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorTheme.surface,
          ),
          child: Text("button 2", style: context.textTheme.labelSmall),
        ),
      ],
    );
  }
}

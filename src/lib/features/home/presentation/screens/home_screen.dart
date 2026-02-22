import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/home/presentation/widget/continue_reading.dart';
import 'package:bookreading/features/home/presentation/widget/recommended_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //! Header
        const Header(),
        SizedBox(height: 20.h),
        //! Continue Reading
        const ContinueReading(),
        SizedBox(height: 32.h),
        // //! Recommended
        // SizedBox(height: context.setHeight(16)),
        Text("Recommended", style: context.textTheme.headlineMedium),
        SizedBox(height: 16.h),
        const RecommendedSection(category: "recommended"),
        // SizedBox(height: context.setHeight(50)),
        // Text("Popular", style: context.headlineMedium()),
        // SizedBox(height: context.setHeight(16)),
        // const HorizontalView(category: "popular"),
        SizedBox(height: 10.h),
      ],
    );
  }
}

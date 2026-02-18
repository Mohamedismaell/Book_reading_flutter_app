import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/home/presentation/widget/continue_reading.dart';
import 'package:bookreading/features/home/presentation/widget/horizontal_view.dart';
import 'package:bookreading/features/home/presentation/manager/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../book/presentation/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..userInfo(),
      // ..getProgress(),
      child: ListView(
        children: [
          //! Header
          const Header(),
          SizedBox(height: 20.h),
          //! Continue Reading
          Text("Continue Reading", style: context.headlineMedium()),
          SizedBox(height: 16.h),
          const ContinueReading(),
          SizedBox(height: 32.h),
          // //! Recommended
          // SizedBox(height: context.setHeight(16)),
          Text("Recommended", style: context.headlineMedium()),
          SizedBox(height: 16.h),
          const HorizontalView(category: "recommended"),
          // SizedBox(height: context.setHeight(50)),
          // Text("Popular", style: context.headlineMedium()),
          // SizedBox(height: context.setHeight(16)),
          // const HorizontalView(category: "popular"),
        ],
      ),
    );
  }
}

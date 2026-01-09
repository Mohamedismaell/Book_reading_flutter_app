import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/books.dart';
import 'package:bookreading/features/book/presentation/widget/horizontal_view.dart';
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
        SizedBox(height: context.setHeight(16)),
        //! Continue Reading
        Text("Continue Reading", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const ContinueReading(),
        SizedBox(height: context.setHeight(32)),
        //! Recommended
        SizedBox(height: context.setHeight(16)),
        Text("Recommended", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const HorizontalView(),
        SizedBox(height: context.setHeight(50)),
        Text("Popular", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const HorizontalView(),
      ],
    );
  }
}

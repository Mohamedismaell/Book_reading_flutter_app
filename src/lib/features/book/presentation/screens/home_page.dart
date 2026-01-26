import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/presentation/widgets/horizontal_view.dart';
import 'package:flutter/material.dart';
import '../widgets/continue_reading.dart';
import '../widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        //! Header
        const Header(),
        SizedBox(height: context.setHeight(20)),
        //! Continue Reading
        Text("Continue Reading", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const ContinueReading(),
        SizedBox(height: context.setHeight(32)),
        //! Recommended
        SizedBox(height: context.setHeight(16)),
        Text("Recommended", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const HorizontalView(category: "recommended"),
        SizedBox(height: context.setHeight(50)),
        Text("Popular", style: context.headlineMedium()),
        SizedBox(height: context.setHeight(16)),
        const HorizontalView(category: "popular"),
      ],
    );
  }
}

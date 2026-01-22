import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:flutter/material.dart';

class WhiteContianer extends StatelessWidget {
  const WhiteContianer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: context.colorTheme.surface,
        // boxShadow: [AppShadows.containerSahdow],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(25),
          vertical: context.setHeight(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.setWidth(12)),
          child: child,
        ),
      ),
    );
  }
}

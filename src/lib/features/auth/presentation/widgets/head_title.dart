import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:flutter/material.dart';

class HeadTitle extends StatelessWidget {
  const HeadTitle({super.key, required this.headText, required this.hashText});

  final String headText;
  final String hashText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(headText, style: context.headlineLarge()),
        SizedBox(height: context.setHeight(8)),
        Text(hashText, style: context.bodySmall()),
      ],
    );
  }
}

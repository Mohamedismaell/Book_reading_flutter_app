import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, this.text});

  final String? text;
  @override
  Widget build(BuildContext context) {
    //Todo fix theme
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.canPop() ? context.pop() : null,
          color: context.colorTheme.onSurface,
          icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
        ),
        // Spacer(),
        Text(text ?? '', style: context.headlineMedium()),
        Icon(
          Icons.bookmark,
          size: context.setMinSize(32),
          color: context.colorTheme.primary,
        ),
      ],
    );
  }
}

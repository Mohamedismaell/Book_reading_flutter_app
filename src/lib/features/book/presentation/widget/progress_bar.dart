import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress, required this.width});

  final double width;
  final double progress;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: context.colorTheme.surface,
          ),
        ),
        Container(
          width: width / 2,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: context.colorTheme.onSurface,
          ),
        ),
      ],
    );
  }
}

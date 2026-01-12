import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress});

  final double progress;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (progress / 100),
      color: context.colorTheme.onSurface,
      backgroundColor: context.colorTheme.surface,
    );
  }
}

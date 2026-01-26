import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress});

  final double progress;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: context.setHeight(7),
      borderRadius: BorderRadius.circular(20),
      value: (progress),
      color: context.colorTheme.onSurface,
      backgroundColor: context.colorTheme.surface,
    );
  }
}

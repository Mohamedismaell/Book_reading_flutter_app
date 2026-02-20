import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isActive,
  });
  final String title;
  final bool isActive;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? context.colorTheme.primary
              : Color(0XFF27272A),
        ),
        onPressed: onPressed,
        child: Text(title, style: context.textTheme.labelSmall),
      ),
    );
  }
}

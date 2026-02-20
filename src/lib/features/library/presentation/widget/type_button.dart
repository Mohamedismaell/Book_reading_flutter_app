import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class LibraryTypeButton extends StatelessWidget {
  const LibraryTypeButton({
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isActive ? context.colorTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: onPressed,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: context.textTheme.labelSmall!.copyWith(
              color: isActive
                  ? context.colorTheme.onPrimary
                  : context.colorTheme.onSurface.withOpacity(0.8),
            ),
            child: Text(
              title,
              // key: ValueKey(title),
              style: context.textTheme.labelSmall!.copyWith(
                color: isActive
                    ? context.colorTheme.onPrimary
                    : context.colorTheme.onSurface.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

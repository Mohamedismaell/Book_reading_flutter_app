import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class PickOption extends StatelessWidget {
  const PickOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 26),
            const SizedBox(width: 16),
            Text(title, style: context.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

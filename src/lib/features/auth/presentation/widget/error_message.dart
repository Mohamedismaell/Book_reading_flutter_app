import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class NoteMessage extends StatelessWidget {
  const NoteMessage({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(16)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: context.bodySmall()),
      ),
    );
  }
}

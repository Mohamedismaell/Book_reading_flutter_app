import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("Saved");
      },
      child: Text("Save", style: context.textTheme.headlineSmall),
    );
  }
}

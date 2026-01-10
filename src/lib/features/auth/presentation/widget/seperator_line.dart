import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SeperatorLine extends StatelessWidget {
  const SeperatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: context.setWidth(78),
            height: context.setHeight(3),
            //Todo Fix Color
            decoration: BoxDecoration(
              color: AppSemanticColors.textSecondaryLight,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.setWidth(12)),
          child: Text(
            "OR CONTINUE WITH",
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: context.setSp(13),
            ),
          ),
        ),
        Flexible(
          child: Container(
            width: context.setWidth(78),
            height: context.setHeight(3),
            decoration: BoxDecoration(
              color: AppSemanticColors.textSecondaryLight,
            ),
          ),
        ),
      ],
    );
  }
}

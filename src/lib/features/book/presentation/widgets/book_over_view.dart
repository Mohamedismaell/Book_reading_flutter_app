import 'dart:ui';

import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class BookOverview extends StatelessWidget {
  const BookOverview({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeProvider.width,
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(context.setMinSize(24)),
      ),
      padding: EdgeInsets.all(context.setMinSize(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.headlineMedium()),
          SizedBox(height: context.setHeight(10)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setWidth(7)),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium().copyWith(fontSize: context.setSp(18)),
            ),
          ),

          Center(
            child: TextButton.icon(
              onPressed: () {
                _showReadMoreDialog(
                  context,
                  title: title,
                  description: description,
                );
              },
              label: Text(
                "Read More",
                style: context.labelLarge().copyWith(
                  color: AppSemanticColors.primaryActionDark,
                ),
              ),
              iconAlignment: IconAlignment.end,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: context.setSp(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showReadMoreDialog(
  BuildContext context, {
  required String title,
  required String description,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Read more",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (_, _, _) {
      return _ReadMore(title: title, description: description);
    },

    transitionBuilder: (_, animation, _, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.94,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}

class _ReadMore extends StatelessWidget {
  const _ReadMore({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.45)),
            ),
          ),
        ),

        Center(
          child: Material(
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(context.setMinSize(24)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxHeight: 500),
              decoration: BoxDecoration(
                color: context.colorTheme.surfaceContainer,
                // color: Colors.transparent,
                borderRadius: BorderRadius.circular(context.setMinSize(24)),
              ),
              padding: EdgeInsets.symmetric(
                vertical: context.setMinSize(30),
                horizontal: context.setMinSize(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.headlineMedium()),
                  SizedBox(height: context.setHeight(10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(7),
                    ),
                    child: Text(
                      description,
                      style: context.bodyMedium().copyWith(
                        fontSize: context.setSp(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

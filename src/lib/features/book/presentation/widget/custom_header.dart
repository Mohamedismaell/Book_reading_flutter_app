import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.isheader,
    this.title,
    this.author,
  });

  final String? title;
  final String? author;
  final bool isheader;
  @override
  Widget build(BuildContext context) {
    //Todo fix theme
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => context.canPop() ? context.pop() : null,
          color: context.colorTheme.onSurface,
          icon: Icon(Icons.arrow_back, size: context.setMinSize(26)),
        ),
        // Spacer(),
        isheader
            ? Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(30),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: context.headlineMedium().copyWith(
                          color: context.colorTheme.onSurface.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: context.setHeight(10)),
                      Text(
                        author!,
                        style: context.bodyLarge().copyWith(
                          fontSize: context.setSp(20),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),

        Icon(
          Icons.bookmark,
          size: context.setMinSize(32),
          color: context.colorTheme.primary,
        ),
      ],
    );
  }
}

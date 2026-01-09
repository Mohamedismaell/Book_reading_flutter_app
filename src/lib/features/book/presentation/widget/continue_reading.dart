import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/progress_bar.dart';
import 'package:flutter/material.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(350, 180),
      width: context.setWidth(350),
      height: context.setHeight(230),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeProvider.width,
            height: context.sizeProvider.height,
            decoration: BoxDecoration(
              color: context.colorTheme.surfaceContainer,
              // shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(context.setMinSize(16)),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.setMinSize(16)),
              child: _CardItem(),
            ),
          );
        },
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BookCover(),
        SizedBox(width: context.setMinSize(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Book Class", style: context.bodyMedium()),
              SizedBox(height: context.setMinSize(2)),
              Text("Book Title", style: context.headlineMedium()),
              Expanded(child: Text("Book Author", style: context.bodyMedium())),
              SizedBox(height: context.setMinSize(10)),
              _Progress(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(context.setMinSize(16)),

      child: Image.asset("assets/images/dune.png", fit: BoxFit.cover),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(child: Text("Chapter 4", style: context.bodySmall())),
            Container(
              width: context.setMinSize(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorTheme.surface,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow_outlined,
                  size: context.setMinSize(24),
                  color: context.colorTheme.onSurface,
                ),
              ),
            ),
            SizedBox(width: context.setMinSize(6)),
            Text(
              "45%",
              style: context.bodySmall().copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: context.setMinSize(8)),
        LayoutBuilder(
          builder: (context, constraints) {
            return ProgressBar(progress: 45, width: constraints.maxWidth);
          },
        ),
      ],
    );
  }
}

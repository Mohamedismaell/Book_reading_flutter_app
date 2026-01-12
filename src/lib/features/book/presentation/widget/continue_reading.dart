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
      baseSize: const Size(350, 310),
      width: context.setWidth(350),
      height: context.setHeight(310),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeProvider.width,
            height: context.sizeProvider.height,
            decoration: BoxDecoration(
              color: context.colorTheme.surfaceContainer,
              // shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(context.setMinSize(24)),
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.setMinSize(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Book Class", style: context.bodyLarge()),
                SizedBox(height: context.setMinSize(10)),
                Text("Book Title", style: context.headlineMedium()),
                SizedBox(height: context.setMinSize(10)),
                Text("Book Author", style: context.bodyLarge()),
                SizedBox(height: context.setMinSize(10)),
                Expanded(child: _Progress()),
              ],
            ),
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

      child: SizedBox(
        width: context.sizeProvider.width / 2.3,
        height: double.infinity,
        child: Image.asset(
          "assets/images/back_ground_auth.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress();

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
        ProgressBar(progress: 30),
        // LayoutBuilder(
        //   builder: (context, constraints) {
        //     return  ProgressBar(progress: 50) ;
        //   },
        // ),
      ],
    );
  }
}

import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:bookreading/features/book/presentation/widget/star_rate.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(),
        Expanded(child: _BookCover()),
        SizedBox(height: context.setHeight(35)),
        _BookOverview(
          title: 'About the author',
          description:
              'J.D. Salinger was an American writer, best known for his 1951 novel The Catcher in the Rye. Before its publi cation, Salinger published several short stories in Story magazine',
        ),
        SizedBox(height: context.setHeight(18)),
        _BookOverview(
          title: 'Overview',
          description:
              'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adu lts but is often read by adolescents for its theme of angst, alienation and as a critique......',
        ),
        SizedBox(height: context.setHeight(20)),
        _Buttons(),
        SizedBox(height: context.setHeight(25)),
      ],
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover();

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(220, 430),
      width: context.setWidth(220),
      height: context.setHeight(430),
      child: Builder(
        builder: (context) {
          return SizedBox(
            width: context.sizeProvider.width,
            height: context.sizeProvider.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: context.sizeProvider.width,
                      height: context.sizeProvider.height * 0.8,
                      child: Image.asset(
                        'assets/images/dune.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.setHeight(15)),
                Text('Book title', style: context.headlineMedium()),
                SizedBox(height: context.setHeight(6)),
                Text('Book author', style: context.bodyLarge()),
                SizedBox(height: context.setHeight(6)),
                const Star(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BookOverview extends StatelessWidget {
  const _BookOverview({required this.title, required this.description});

  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.labelLarge()),
        SizedBox(height: context.setHeight(6)),
        Text(
          description,
          style: context.bodyMedium().copyWith(fontSize: context.setSp(14)),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text("button 1", style: context.labelSmall()),
        ),
        SizedBox(width: context.setWidth(20)),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorTheme.surface,
          ),
          child: Text("button 2", style: context.labelSmall()),
        ),
      ],
    );
  }
}

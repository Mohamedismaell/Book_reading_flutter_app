import 'dart:ui';

import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/app_semantic_colors.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/core/theme/extensions/theme_extension.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:bookreading/features/book/presentation/widget/star_rate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookDetails extends StatefulWidget {
  final BookModel book;
  final Object? heroTag;
  const BookDetails({super.key, required this.book, this.heroTag});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return Column(
      children: [
        CustomHeader(isheader: false),
        _BookCover(
          coverUrl: book.coverUrl!,
          title: book.title,
          author: book.author!,
          id: book.id,
          heroTag: widget.heroTag,
        ),
        SizedBox(height: context.setHeight(35)),
        _BookOverview(title: 'Overview', description: book.summary!),
        SizedBox(height: context.setHeight(18)),
        // SizedBox(height: context.setHeight()),
        _Buttons(book: book),
        // SizedBox(height: context.setHeight(25)),
      ],
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({
    required this.coverUrl,
    required this.author,
    required this.title,
    required this.id,
    this.heroTag,
  });
  final String coverUrl;
  final String author;
  final String title;
  final int id;
  final Object? heroTag;
  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(220, 430),
      width: context.setWidth(220),
      height: context.setHeight(430),
      child: Builder(
        builder: (context) {
          return SizedBox(
            // width: context.sizeProvider.width,
            // height: context.sizeProvider.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: context.sizeProvider.width,
                    // height: context.sizeProvider.height * 0.1,
                    child: Hero(
                      tag: heroTag ?? id,
                      child: Image.network(coverUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: context.setHeight(15)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.headlineMedium(),
                ),
                SizedBox(height: context.setHeight(10)),
                Text(
                  author,
                  style: context.bodyLarge().copyWith(
                    fontSize: context.setSp(20),
                  ),
                ),
                SizedBox(height: context.setHeight(10)),
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

          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium().copyWith(fontSize: context.setSp(18)),
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
    transitionDuration: const Duration(milliseconds: 400),

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
              // height: MediaQuery.of(context).size.height * 0.9,
              constraints: const BoxConstraints(maxHeight: 500),
              decoration: BoxDecoration(
                color: context.colorTheme.surfaceContainer,
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
                  Text(
                    description,
                    style: context.bodyMedium().copyWith(
                      fontSize: context.setSp(18),
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

class _Buttons extends StatelessWidget {
  const _Buttons({required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Todo fix the Button Later
        ElevatedButton(
          onPressed: () => context.push(AppRoutes.readPage, extra: book),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(50),
              vertical: context.setMinSize(17),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12),
            // ),
          ),
          child: Text("Read", style: context.labelMedium()),
        ),
        SizedBox(width: context.setWidth(20)),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(50),
              vertical: context.setMinSize(17),
            ),
            backgroundColor: AppSemanticColors.secondaryActionDark,
          ),

          child: Text("Listen", style: context.labelMedium()),
        ),
      ],
    );
  }
}

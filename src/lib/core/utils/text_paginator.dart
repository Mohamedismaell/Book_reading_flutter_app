import 'package:flutter/material.dart';

class TextPaginator {
  final String fullText;
  final double width;
  final double height;
  final TextDirection textDirection;

  TextPaginator({
    required this.fullText,
    required this.width,
    required this.height,
    this.textDirection = TextDirection.ltr,
  });

  List<String> paginate({required TextStyle style}) {
    final List<String> pages = [];

    final textPainter = TextPainter(
      textDirection: textDirection,
      maxLines: null,
    );

    int startIndex = 0;

    while (startIndex < fullText.length) {
      textPainter.text = TextSpan(
        text: fullText.substring(startIndex),
        style: style,
      );

      textPainter.layout(maxWidth: width);

      final lines = textPainter.computeLineMetrics();

      if (lines.isEmpty) {
        break;
      }

      double usedHeight = 0;
      int lastLineIndex = -1;

      for (int i = 0; i < lines.length; i++) {
        final line = lines[i];
        final nextHeight = usedHeight + line.height;

        if (nextHeight > height) break;

        usedHeight = nextHeight;
        lastLineIndex = i;
      }

      if (lastLineIndex == -1) {
        pages.add(fullText[startIndex]);
        startIndex += 1;
        continue;
      }

      final line = lines[lastLineIndex];

      final endPosition = textPainter.getPositionForOffset(
        Offset(width - 1, line.baseline),
      );

      int endIndex = startIndex + endPosition.offset;

      if (endIndex < fullText.length) {
        final lastSpace = fullText.lastIndexOf(' ', endIndex);
        if (lastSpace > startIndex) {
          endIndex = lastSpace + 1;
        }
      }

      pages.add(fullText.substring(startIndex, endIndex).trimRight());

      startIndex = endIndex;
    }

    textPainter.dispose();
    return pages;
  }
}

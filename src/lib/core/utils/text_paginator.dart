import 'package:flutter/material.dart';

class TextPaginator {
  final String fullText;
  final double width;
  final double height;
  // final Function style;
  final TextDirection textDirection;

  TextPaginator({
    required this.fullText,
    required this.width,
    required this.height,
    // required this.style,
    this.textDirection = TextDirection.ltr,
  });

  final List<String> pages = [];

  List<String> paginate({required TextStyle style}) {
    pages.clear();

    final textPainter = TextPainter(textDirection: textDirection);

    int startIndex = 0;

    while (startIndex < fullText.length) {
      textPainter.text = TextSpan(
        text: fullText.substring(startIndex),
        style: style,
      );

      textPainter.layout(maxWidth: width);

      //!Last Character Position
      // final position = textPainter.getPositionForOffset(Offset(width, height));
      final lines = textPainter.computeLineMetrics();
      final lastLine = lines.lastWhere(
        (line) => (line.baseline - line.ascent + line.height) <= height,
        orElse: () => lines.first,
      );
      // print('Lastline here ${lastLine.baseline}');
      // print('Lastline here ${lastLine.descent}');
      // print('Lastline here ${lastLine.height}');
      final pos = textPainter.getPositionForOffset(
        Offset(width, lastLine.baseline),
      );

      int endIndex = startIndex + pos.offset;
      if (endIndex <= startIndex) {
        endIndex = startIndex + 1;
      }

      if (endIndex < fullText.length) {
        final lastSpace = fullText.lastIndexOf(' ', endIndex);
        if (lastSpace > startIndex) {
          endIndex = lastSpace + 1;
        }
      }

      pages.add(fullText.substring(startIndex, endIndex));
      startIndex = endIndex;
    }

    return pages;
  }
}

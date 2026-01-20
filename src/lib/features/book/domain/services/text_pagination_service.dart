import 'package:flutter/material.dart';

class TextPaginationService {
  final String fullText;
  final double width;
  final double height;
  final TextDirection textDirection;
  static const double _chunkSizeMultiplier = 1.5;
  static const int _tabletChunkSize = 8000;
  static const int _phoneChunkSize = 3000;
  static const double _tabletWidthThreshold = 600;
  TextPaginationService({
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
    final bool isTablet = width > _tabletWidthThreshold;
    int currentChunkSize = isTablet ? _tabletChunkSize : _phoneChunkSize;

    while (startIndex < fullText.length) {
      final pageResult = _extractNextPage(
        textPainter: textPainter,
        startIndex: startIndex,
        currentChunkSize: currentChunkSize,
        style: style,
      );

      if (pageResult.pageContent != null) {
        pages.add(pageResult.pageContent!);
      }

      startIndex = pageResult.nextStartIndex;
      currentChunkSize = pageResult.nextChunkSize;
    }

    textPainter.dispose();
    return pages;
  }

  _PageExtractionResult _extractNextPage({
    required TextPainter textPainter,
    required int startIndex,
    required int currentChunkSize,
    required TextStyle style,
  }) {
    int chunkSize = currentChunkSize;

    while (true) {
      int guessLimit = startIndex + chunkSize;
      if (guessLimit > fullText.length) guessLimit = fullText.length;

      final String textChunk = fullText.substring(startIndex, guessLimit);

      textPainter.text = TextSpan(text: textChunk, style: style);
      textPainter.layout(maxWidth: width);

      final lines = textPainter.computeLineMetrics();

      if (lines.isEmpty) {
        return _PageExtractionResult(
          pageContent: null,
          nextStartIndex: fullText.length,
          nextChunkSize: chunkSize,
        );
      }

      final fittingResult = _findLastFittingLine(lines);

      if (!fittingResult.didFillScreen && guessLimit < fullText.length) {
        chunkSize = (chunkSize * _chunkSizeMultiplier).toInt();
        continue;
      }

      if (fittingResult.lastFittingLineIndex == -1) {
        return _PageExtractionResult(
          pageContent: fullText[startIndex],
          nextStartIndex: startIndex + 1,
          nextChunkSize: chunkSize,
        );
      }

      final globalEndIndex = _calculatePageEndIndex(
        textPainter: textPainter,
        lines: lines,
        lastFittingLineIndex: fittingResult.lastFittingLineIndex,
        startIndex: startIndex,
      );

      return _PageExtractionResult(
        pageContent: fullText.substring(startIndex, globalEndIndex).trimRight(),
        nextStartIndex: globalEndIndex,
        nextChunkSize: chunkSize,
      );
    }
  }

  _LineFittingResult _findLastFittingLine(List<LineMetrics> lines) {
    double usedHeight = 0.0;
    int lastFittingLineIndex = -1;

    for (int i = 0; i < lines.length; i++) {
      if (usedHeight + lines[i].height > height) {
        return _LineFittingResult(
          lastFittingLineIndex: lastFittingLineIndex,
          didFillScreen: true,
        );
      }
      usedHeight += lines[i].height;
      lastFittingLineIndex = i;
    }

    return _LineFittingResult(
      lastFittingLineIndex: lastFittingLineIndex,
      didFillScreen: false,
    );
  }

  int _calculatePageEndIndex({
    required TextPainter textPainter,
    required List<LineMetrics> lines,
    required int lastFittingLineIndex,
    required int startIndex,
  }) {
    final line = lines[lastFittingLineIndex];
    final endPosition = textPainter.getPositionForOffset(
      Offset(width, line.baseline),
    );

    int chunkEndIndex = endPosition.offset;
    int globalEndIndex = startIndex + chunkEndIndex;

    if (globalEndIndex < fullText.length) {
      final lastSpace = fullText.lastIndexOf(' ', globalEndIndex);
      if (lastSpace > startIndex) {
        globalEndIndex = lastSpace + 1;
      }
    }

    return globalEndIndex;
  }
}

class _PageExtractionResult {
  final String? pageContent;
  final int nextStartIndex;
  final int nextChunkSize;

  const _PageExtractionResult({
    required this.pageContent,
    required this.nextStartIndex,
    required this.nextChunkSize,
  });
}

class _LineFittingResult {
  final int lastFittingLineIndex;
  final bool didFillScreen;

  const _LineFittingResult({
    required this.lastFittingLineIndex,
    required this.didFillScreen,
  });
}

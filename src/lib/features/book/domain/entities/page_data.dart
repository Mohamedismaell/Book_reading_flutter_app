/// Represents a single page of content in the reader.
///
/// This is a value object in DDD terms - it's immutable and
/// identified by its attributes rather than an ID.
class PageData {
  final String text;
  final int chapterIndex;
  final int pageNumber;
  final int contentLength;

  const PageData({
    required this.text,
    required this.chapterIndex,
    required this.pageNumber,
  }) : contentLength = text.length;

  /// Creates a copy of this [PageData] with the given fields replaced.
  PageData copyWith({String? text, int? chapterIndex, int? pageNumber}) {
    return PageData(
      text: text ?? this.text,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PageData &&
        other.text == text &&
        other.chapterIndex == chapterIndex &&
        other.pageNumber == pageNumber;
  }

  @override
  int get hashCode => Object.hash(text, chapterIndex, pageNumber);

  @override
  String toString() =>
      'PageData(chapterIndex: $chapterIndex, pageNumber: $pageNumber, length: $contentLength)';
}

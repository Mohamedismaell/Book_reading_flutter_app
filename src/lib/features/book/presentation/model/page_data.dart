class PageData {
  final String text;
  final int chapterIndex;
  final int pageNumber;
  final int contentLength;
  PageData({
    required this.text,
    required this.chapterIndex,
    required this.pageNumber,
  }) : contentLength = text.length;
}

import 'package:equatable/equatable.dart';

class PageData extends Equatable {
  final String text;
  final int chapterIndex;
  final int pageNumber;
  final int contentLength;

  const PageData({
    required this.text,
    required this.chapterIndex,
    required this.pageNumber,
  }) : contentLength = text.length;

  PageData copyWith({String? text, int? chapterIndex, int? pageNumber}) {
    return PageData(
      text: text ?? this.text,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object?> get props => [text, chapterIndex, pageNumber, contentLength];
  @override
  String toString() =>
      'PageData(chapterIndex: $chapterIndex, pageNumber: $pageNumber, length: $contentLength)';
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book/data/models/chapter_model.dart';

class ProgressModel {
  final int bookId;
  final String chapterId;
  // final int pageIndex;
  final DateTime updatedAt;
  final BookModel? bookDetails;
  final ChapterModel? chapterDetails;
  final int pageNumber;
  final double percentage;
  ProgressModel({
    required this.bookId,
    required this.chapterId,
    required this.updatedAt,
    this.bookDetails,
    this.chapterDetails,
    required this.pageNumber,
    required this.percentage,
  });

  ProgressModel copyWith({
    int? bookId,
    String? chapterId,
    DateTime? updatedAt,
    BookModel? bookDetails,
    ChapterModel? chapterDetails,
    int? pageNumber,
    double? percentage,
  }) {
    return ProgressModel(
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      updatedAt: updatedAt ?? this.updatedAt,
      bookDetails: bookDetails ?? this.bookDetails,
      chapterDetails: chapterDetails ?? this.chapterDetails,
      pageNumber: pageNumber ?? this.pageNumber,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'book_id': bookId,
      'chapter_id': chapterId,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'books': bookDetails?.toMap(),
      'chapters': chapterDetails?.toMap(),
      'page_number': pageNumber,
      'progress_percentage': percentage,
    };
  }

  //Todo Check updatedAt Type
  factory ProgressModel.fromJsonMap(Map<String, dynamic> map) {
    return ProgressModel(
      bookId: map['book_id'] as int,
      chapterId: map['chapter_id'] as String,
      updatedAt: DateTime.parse(map['updated_at'] as String),
      bookDetails: map['books'] != null
          ? BookModel.fromJsonMap(map['books'] as Map<String, dynamic>)
          : null,
      chapterDetails: map['chapters'] != null
          ? ChapterModel.fromJsonMap(map['chapters'] as Map<String, dynamic>)
          : null,
      pageNumber: map['page_number'] as int,
      percentage: map['progress_percentage'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressModel.fromJsonString(String source) =>
      ProgressModel.fromJsonMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProgressModel(book_id: $bookId, chapter_id: $chapterId, updated_at: $updatedAt, bookDetails: $bookDetails, chapterDetails: $chapterDetails, page_number: $pageNumber, progress_percentage: $percentage)';
  }

  @override
  bool operator ==(covariant ProgressModel other) {
    if (identical(this, other)) return true;

    return other.bookId == bookId &&
        other.chapterId == chapterId &&
        other.updatedAt == updatedAt &&
        other.bookDetails == bookDetails &&
        other.chapterDetails == chapterDetails &&
        other.pageNumber == pageNumber &&
        other.percentage == percentage;
  }

  @override
  int get hashCode {
    return bookId.hashCode ^
        chapterId.hashCode ^
        updatedAt.hashCode ^
        bookDetails.hashCode ^
        chapterDetails.hashCode ^
        pageNumber.hashCode ^
        percentage.hashCode;
  }
}

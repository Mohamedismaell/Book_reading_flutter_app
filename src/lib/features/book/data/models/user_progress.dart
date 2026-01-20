import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';

class UserProgressModel {
  final int bookId;
  final String chapterId;
  // final int pageIndex;
  final DateTime updatedAt;
  final BookModel? bookDetails;
  final ChapterModel? chapterDetails;
  final double progressPercentage;
  UserProgressModel({
    required this.bookId,
    required this.chapterId,
    // required this.pageIndex,
    required this.updatedAt,
    this.bookDetails,
    this.chapterDetails,
    required this.progressPercentage,
  });

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      bookId: json['book_id'] as int,
      chapterId: json['chapter_id'] as String,
      // pageIndex: json['page_index'] != null ? json['page_index'] as int : 0,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      bookDetails: json['books'] != null
          ? BookModel.fromJson(json['books'])
          : null,
      chapterDetails: json['chapters'] != null
          ? ChapterModel.fromJson(json['chapters'])
          : null,
      progressPercentage: json['progress'] != null
          ? json['progress'] as double
          : 0.0,
    );
  }
}

import 'package:bookreading/features/book/data/models/books.dart';

class BookMarksModel {
  final BookModel? bookDetails;
  final double progressPercentage;
  final DateTime updatedAt;
  BookMarksModel({
    required this.bookDetails,
    required this.progressPercentage,
    required this.updatedAt,
  });

  factory BookMarksModel.fromJson(Map<String, dynamic> json) {
    return BookMarksModel(
      bookDetails: json['books'] != null
          ? BookModel.fromJson(json['books'])
          : null,
      progressPercentage: json['progress'] != null
          ? (json['progress'] as num).toDouble()
          : 0.0,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  BookMarksModel copyWith({
    BookModel? bookDetails,
    double? progressPercentage,
    DateTime? updatedAt,
  }) {
    return BookMarksModel(
      bookDetails: bookDetails ?? this.bookDetails,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'BookMarksModel(bookDetails: $bookDetails, progressPercentage: $progressPercentage, updatedAt: $updatedAt)';
}

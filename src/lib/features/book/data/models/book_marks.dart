import 'package:bookreading/features/book/data/models/books.dart';

class BookMarksModel {
  final BookModel? bookDetails;
  final double progressPercentage;
  final DateTime createdAt;
  BookMarksModel({
    required this.bookDetails,
    required this.progressPercentage,
    required this.createdAt,
  });

  factory BookMarksModel.fromJson(Map<String, dynamic> json) {
    double progress = 0.0;

    // 1. Check if 'books' exists
    if (json['books'] != null) {
      // 2. Look for 'user_progress' INSIDE 'books'
      final bookData = json['books'];
      final progressList = bookData['user_progress'] as List?;

      if (progressList != null && progressList.isNotEmpty) {
        // 3. (Optional but Safe) Filter to find the current user's progress
        // If you have Row Level Security (RLS) enabled in Supabase,
        // this list will only contain 1 item (your own).
        // If not, it might contain everyone's progress, so we take the first one or filter.
        progress = (progressList[0]['progress'] as num).toDouble();
      }
    }

    return BookMarksModel(
      bookDetails: json['books'] != null
          ? BookModel.fromJson(json['books'])
          : null,
      progressPercentage: progress,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  BookMarksModel copyWith({
    BookModel? bookDetails,
    double? progressPercentage,
    DateTime? createdAt,
  }) {
    return BookMarksModel(
      bookDetails: bookDetails ?? this.bookDetails,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() =>
      'BookMarksModel(bookDetails: $bookDetails, progressPercentage: $progressPercentage, createdAt: $createdAt)';
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserStatsModel extends Equatable {
  final int readingStreak;
  final int readingDays;
  final int booksCompleted;
  final int totalReadingMinutes;
  final int booksFavorite;
  final DateTime? lastReadAt;
  const UserStatsModel({
    required this.readingStreak,
    required this.readingDays,
    required this.booksCompleted,
    required this.totalReadingMinutes,
    required this.booksFavorite,
    this.lastReadAt,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      readingStreak: json['reading_streak'] ?? 0,
      readingDays: json['reading_days'] ?? 0,
      booksCompleted: json['books_completed'] ?? 0,
      totalReadingMinutes: json['total_reading_minutes'] ?? 0,
      booksFavorite: json['books_favorite'] ?? 0,
      lastReadAt: json['last_read_at'] != null
          ? DateTime.parse(json['last_read_at'].toString())
          : null,
    );
  }

  UserStatsModel copyWith({
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    int? booksFavorite,
    DateTime? lastReadAt,
  }) {
    return UserStatsModel(
      readingStreak: readingStreak ?? this.readingStreak,
      readingDays: readingDays ?? this.readingDays,
      booksCompleted: booksCompleted ?? this.booksCompleted,
      totalReadingMinutes: totalReadingMinutes ?? this.totalReadingMinutes,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      booksFavorite: booksFavorite ?? this.booksFavorite,
    );
  }

  @override
  List<Object?> get props {
    return [
      readingStreak,
      readingDays,
      booksCompleted,
      totalReadingMinutes,
      lastReadAt,
      booksFavorite,
    ];
  }
}

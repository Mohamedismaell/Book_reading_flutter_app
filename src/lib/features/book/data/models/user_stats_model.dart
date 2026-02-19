class UserStatsModel {
  final int readingStreak;
  final int readingDays;
  final int booksCompleted;
  final int totalReadingMinutes;
  final DateTime? lastReadAt;

  UserStatsModel({
    required this.readingStreak,
    required this.readingDays,
    required this.booksCompleted,
    required this.totalReadingMinutes,
    this.lastReadAt,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      readingStreak: json['reading_streak'] ?? 0,
      readingDays: json['reading_days'] ?? 0,
      booksCompleted: json['books_completed'] ?? 0,
      totalReadingMinutes: json['total_reading_minutes'] ?? 0,
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
    DateTime? lastReadAt,
  }) {
    return UserStatsModel(
      readingStreak: readingStreak ?? this.readingStreak,
      readingDays: readingDays ?? this.readingDays,
      booksCompleted: booksCompleted ?? this.booksCompleted,
      totalReadingMinutes: totalReadingMinutes ?? this.totalReadingMinutes,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }
}

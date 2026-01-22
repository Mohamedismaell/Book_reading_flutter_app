class UserStats {
  final int readingStreak;
  final int readingDays;
  final int booksCompleted;
  final int totalReadingMinutes;
  final DateTime lastReadAt;
  final DateTime updatedAt;

  UserStats({
    required this.readingStreak,
    required this.readingDays,
    required this.booksCompleted,
    required this.totalReadingMinutes,
    required this.lastReadAt,
    required this.updatedAt,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      readingStreak: json['reading_streak'] as int,
      readingDays: json['reading_days'] as int,
      booksCompleted: json['books_completed'] as int,
      totalReadingMinutes: json['total_reading_minutes'] as int,
      lastReadAt: DateTime.parse(json['last_read_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

import 'dart:io';

import 'package:bookreading/core/connections/result.dart';

abstract class BookRepository {
  //*Book Data
  Future<Result> getBooks();
  Future<Result> getChapters(int bookId);
  Future<Result> getBookById(int bookId);
  Future<Result> saveProgress({
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required double progressPercentage,
  });
  Future<Result> getProgress();
  Future<Result> updateUserStats({
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
  });
  Future<Result> getUserStats();
  Future<Result> getUserProfile();
  Future<Result> updateUserProfile({
    String? avatarUrl,
    String? language,
    double? textScale,
    bool? darkMode,
  });
  Future<Result> uploadAvatar({required File avatarFile});
  Future<Result> getAvatar({required String avatarPath});
}

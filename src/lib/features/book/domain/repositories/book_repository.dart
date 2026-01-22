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
}

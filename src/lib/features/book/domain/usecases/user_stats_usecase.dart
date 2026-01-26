import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class UpdateUserStats {
  final BookRepository repository;
  UpdateUserStats({required this.repository});
  Future<Result> call({
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
    // DateTime? updatedAt,
  }) async {
    return await repository.updateUserStats(
      readingStreak: readingStreak,
      readingDays: readingDays,
      booksCompleted: booksCompleted,
      totalReadingMinutes: totalReadingMinutes,
      lastReadAt: lastReadAt,
    );
  }
}

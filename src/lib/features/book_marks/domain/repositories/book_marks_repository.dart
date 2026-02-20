import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';

abstract class BookMarksRepository {
  Future<Result> insertBookmark({
    required int bookId,
    // required double progressPercentage,
    // required int chapterId,
  });
  Future<Result> removeBookmark({required int bookId});
  Future<Result<List<BookMarksModel>>> getBookmarks();
  Future<Result<Set<int>>> getBookmarksId();
}

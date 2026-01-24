import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class InsertBookMark {
  final BookRepository repository;
  InsertBookMark({required this.repository});
  Future<Result> call({
    required int bookId,
    // required double progressPercentage,
  }) async {
    return await repository.insertBookmark(
      bookId: bookId,
      // progressPercentage: progressPercentage,
    );
  }
}

class RemoveBookMark {
  final BookRepository repository;
  RemoveBookMark({required this.repository});
  Future<Result> call({required int bookId}) async {
    return await repository.removeBookmark(bookId: bookId);
  }
}

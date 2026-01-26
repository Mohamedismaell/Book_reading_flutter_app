import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class InsertBookMarks {
  final BookRepository repository;
  InsertBookMarks({required this.repository});
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

class RemoveBookMarks {
  final BookRepository repository;
  RemoveBookMarks({required this.repository});
  Future<Result> call({required int bookId}) async {
    return await repository.removeBookmark(bookId: bookId);
  }
}

class GetBookMarks {
  final BookRepository repository;
  GetBookMarks({required this.repository});
  Future<Result> call() async {
    return await repository.getBookmarks();
  }
}

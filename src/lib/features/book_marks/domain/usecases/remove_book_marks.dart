import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book_marks/domain/repositories/book_marks_repository.dart';

class RemoveBookMarks {
  final BookMarksRepository repository;
  RemoveBookMarks({required this.repository});

  Future<Result> call({required int bookId}) async {
    return await repository.removeBookmark(bookId: bookId);
  }
}

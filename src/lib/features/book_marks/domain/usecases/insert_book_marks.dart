import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book_marks/domain/repositories/book_marks_repository.dart';

class InsertBookMarks {
  final BookMarksRepository repository;
  InsertBookMarks({required this.repository});
  Future<Result> call({required int bookId}) async {
    return await repository.insertBookmark(bookId: bookId);
  }
}

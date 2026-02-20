import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:bookreading/features/book_marks/domain/repositories/book_marks_repository.dart';

class GetBookMarksBooks {
  final BookMarksRepository repository;
  GetBookMarksBooks({required this.repository});
  Future<Result<List<BookMarksModel>>> call() async {
    return await repository.getBookmarks();
  }
}

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book_marks/domain/repositories/book_marks_repository.dart';

class GetBookMarksId {
  final BookMarksRepository repository;
  GetBookMarksId({required this.repository});
  Future<Result<Set<int>>> call() async {
    return await repository.getBookmarksId();
  }
}

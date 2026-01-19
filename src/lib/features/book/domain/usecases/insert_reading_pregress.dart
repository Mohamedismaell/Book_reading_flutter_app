import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class InsertReadingPregress {
  final BookRepository repository;
  InsertReadingPregress({required this.repository});
  Future<Result> call(
    int bookId,
    String userId,
    String chapterId,
    int pageIndex,
  ) async {
    return await repository.saveProgress(
      bookId: bookId,
      userId: userId,
      chapterId: chapterId,
      pageIndex: pageIndex,
    );
  }
}

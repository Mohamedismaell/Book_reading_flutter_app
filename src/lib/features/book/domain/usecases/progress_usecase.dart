import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetReadingProgress {
  final BookRepository repository;
  GetReadingProgress({required this.repository});
  Future<Result> call() async {
    return await repository.getProgress();
  }
}

class InsertReadingPregress {
  final BookRepository repository;
  InsertReadingPregress({required this.repository});
  Future<Result> call({
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required double progressPercentage,
  }) async {
    return await repository.saveProgress(
      bookId: bookId,
      chapterId: chapterId,
      // pageIndex: pageIndex,
      progressPercentage: progressPercentage,
    );
  }
}

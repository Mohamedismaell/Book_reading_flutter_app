import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/progress/domain/repositories/progress_repository.dart';

class SaveReadingPregress {
  final ProgressRepository repository;
  SaveReadingPregress({required this.repository});
  Future<Result> call({
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required int pageNumber,
    required double percentage,
  }) async {
    return await repository.saveProgress(
      bookId: bookId,
      chapterId: chapterId,
      // pageIndex: pageIndex,
      pageNumber: pageNumber,
      percentage: percentage,
    );
  }
}

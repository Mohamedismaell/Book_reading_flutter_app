import 'package:bookreading/core/connections/result.dart';

abstract class ProgressRepository {
  Future<Result> saveProgress({
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required int pageNumber,
  });
  Future<Result> getProgress();
}

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/progress/domain/repositories/progress_repository.dart';

class GetReadingProgress {
  final ProgressRepository repository;
  GetReadingProgress({required this.repository});
  Future<Result> call() async {
    return await repository.getProgress();
  }
}

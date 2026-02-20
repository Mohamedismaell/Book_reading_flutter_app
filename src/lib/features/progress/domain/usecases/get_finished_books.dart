import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/progress/domain/repositories/progress_repository.dart';

class GetFinishedBooks {
  final ProgressRepository repository;
  GetFinishedBooks({required this.repository});
  Future<Result> call() async {
    return await repository.getFinishedBooks();
  }
}

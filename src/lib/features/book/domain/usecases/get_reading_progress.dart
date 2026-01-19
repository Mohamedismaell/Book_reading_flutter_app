import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetReadingProgress {
  final BookRepository repository;
  GetReadingProgress({required this.repository});
  Future<Result> call() async {
    return await repository.getProgress();
  }
}

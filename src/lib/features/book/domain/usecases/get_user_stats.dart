import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetUserStats {
  final BookRepository repository;
  GetUserStats({required this.repository});
  Future<Result> call() async {
    return await repository.getUserStats();
  }
}

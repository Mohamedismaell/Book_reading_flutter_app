import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetUserProfile {
  final BookRepository repository;
  GetUserProfile({required this.repository});
  Future<Result> call() async {
    return await repository.getUserProfile();
  }
}

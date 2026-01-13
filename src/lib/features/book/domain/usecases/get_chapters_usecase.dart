import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetChaptersUseCase {
  final BookRepository repository;
  GetChaptersUseCase({required this.repository});
  Future<Result> call(int bookId) async {
    return await repository.getChapters(bookId);
  }
}

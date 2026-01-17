import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetBooksIdUseCase {
  final BookRepository repository;
  GetBooksIdUseCase({required this.repository});
  Future<Result> call(int bookId) async {
    return await repository.getBookById(bookId);
  }
}

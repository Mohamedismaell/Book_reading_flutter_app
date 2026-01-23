import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;
  GetBooksUseCase({required this.repository});
  Future<Result> call() async {
    return await repository.getBooks();
  }
}

class GetBooksIdUseCase {
  final BookRepository repository;
  GetBooksIdUseCase({required this.repository});
  Future<Result> call(int bookId) async {
    return await repository.getBookById(bookId);
  }
}

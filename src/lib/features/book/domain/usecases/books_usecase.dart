import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class GetAllBooksUseCase {
  final BookRepository repository;
  GetAllBooksUseCase({required this.repository});
  Future<Result> call() async {
    return await repository.getBooks();
  }
}

class GetBookByIdUseCase {
  final BookRepository repository;
  GetBookByIdUseCase({required this.repository});
  Future<Result> call(int bookId) async {
    return await repository.getBookById(bookId);
  }
}

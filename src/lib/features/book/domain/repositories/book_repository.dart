import 'package:bookreading/core/connections/result.dart';

abstract class BookRepository {
  //*Book Data
  Future<Result> getBooks();
  Future<Result> getChapters(int bookId);
}

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';

abstract class ExploreRepository {
  Future<Result<List<BookModel>>> search({required String query});
  Future<Result<List<BookModel>>> getPopularBooks();
  Future<Result<List<BookModel>>> getCommingSoonBooks();
}

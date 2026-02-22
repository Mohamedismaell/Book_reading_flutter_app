import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/explore/domain/repositories/explore_repository.dart';

class GetPopularBooks {
  final ExploreRepository exploreRepository;
  GetPopularBooks({required this.exploreRepository});

  Future<Result<List<BookModel>>> call() async {
    return await exploreRepository.getPopularBooks();
  }
}

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';

import '../repositories/explore_repository.dart';

class SearchUseCase {
  final ExploreRepository exploreRepository;
  SearchUseCase({required this.exploreRepository});

  Future<Result<List<BookModel>>> call({required String query}) async {
    return await exploreRepository.search(query: query);
  }
}

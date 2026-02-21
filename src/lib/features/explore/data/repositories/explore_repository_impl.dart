import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/explore/data/datasources/explore_data_source.dart';
import 'package:bookreading/features/explore/data/datasources/explore_remote_data_source.dart';

import '../../domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreRemoteDataSource remoteDataSource;
  final ExploreLocalDataSource localDataSource;
  ExploreRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });

  Future<Result<List<BookModel>>> search({required String query}) async {
    try {
      final result = await remoteDataSource.search(query: query);
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }
}

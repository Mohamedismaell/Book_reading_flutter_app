import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/progress/data/datasources/progress_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressRemoteDataSource remoteDataSource;
  // final ProgressLocalDataSource localDataSource;
  ProgressRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    // required this.networkInfo,
  });

  @override
  Future<Result> saveProgress({
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required int pageNumber,
    required double percentage,
  }) async {
    try {
      await remoteDataSource.saveProgress(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        bookId: bookId,
        chapterId: chapterId,
        // pageIndex: pageIndex,
        pageNumber: pageNumber,
        percentage: percentage,
      );
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> getProgress() async {
    try {
      final result = await remoteDataSource.getProgress(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );
      //   if (result == null) {
      //   return Result.ok(null);
      // }
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }
}

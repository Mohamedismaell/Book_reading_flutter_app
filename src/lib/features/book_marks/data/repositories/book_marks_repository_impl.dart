import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:bookreading/features/book_marks/data/datasources/book_marks_data_source.dart';
import 'package:bookreading/features/book_marks/data/datasources/book_marks_remote_data_source.dart';
import 'package:bookreading/features/book_marks/domain/repositories/book_marks_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookMarksRepositoryImpl implements BookMarksRepository {
  final BookMarksRemoteDataSource remoteDataSource;
  final BookMarksLocalDataSource localDataSource;
  BookMarksRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });
  @override
  Future<Result> insertBookmark({
    required int bookId,
    // required double progressPercentage,
  }) async {
    try {
      await remoteDataSource.insertBookmark(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        bookId: bookId,
      );
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> removeBookmark({required int bookId}) async {
    try {
      await remoteDataSource.removeBookmark(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        bookId: bookId,
      );
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result<List<BookMarksModel>>> getBookmarks() async {
    try {
      final result = await remoteDataSource.getBookmarks(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }
}

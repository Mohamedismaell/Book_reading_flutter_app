import 'package:bookreading/core/connections/network_info.dart';
import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/di/service_locator.dart';
import 'package:bookreading/core/errors/failure.dart';
import 'package:bookreading/features/book/data/datasources/books_remote_data_source.dart';

import 'package:bookreading/features/book/domain/repositories/book_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookRepositoryImpl extends BookRepository {
  final NetworkInfo networkInfo;
  final BooksRemoteDataSource remoteDataSource;
  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result> getBooks() async {
    try {
      final result = await remoteDataSource.getBooks();
      return Result.ok(result);
    } on PostgrestException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> getChapters(int bookId) async {
    try {
      final result = await remoteDataSource.getChapters(bookId);
      return Result.ok(result);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> getBookById(int bookId) async {
    try {
      final result = await remoteDataSource.getBookById(bookId);

      if (result == null) {
        return Result.error(Failure(errMessage: 'Book not found'));
      }

      return Result.ok(result);
    } on PostgrestException catch (e) {
      return Result.error(Failure(errMessage: e.message));
    }
  }

  @override
  Future<Result> saveProgress({
    required int bookId,
    required String userId,
    required String chapterId,
    required int pageIndex,
  }) async {
    try {
      await remoteDataSource.saveProgress(
        userId: userId,
        bookId: bookId,
        chapterId: chapterId,
        pageIndex: pageIndex,
      );
      return Result.ok(null);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> getProgress() async {
    try {
      final result = await remoteDataSource.getProgress(userId: sl<User>().id);
      //   if (result == null) {
      //   return Result.ok(null);
      // }
      return Result.ok(result);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }
}

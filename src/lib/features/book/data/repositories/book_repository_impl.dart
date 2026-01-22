import 'dart:io';

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
    required String chapterId,
    // required int pageIndex,
    required double progressPercentage,
  }) async {
    try {
      await remoteDataSource.saveProgress(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        bookId: bookId,
        chapterId: chapterId,
        // pageIndex: pageIndex,
        progressPercentage: progressPercentage,
      );
      return Result.ok(null);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
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
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> getUserStats() async {
    try {
      final result = await remoteDataSource.getUserStats(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );
      //   if (result == null) {
      //   return Result.ok(null);
      // }
      return Result.ok(result);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> updateUserStats({
    // required String userId,
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
    // DateTime? updatedAt,
  }) async {
    try {
      await remoteDataSource.updateUserStats(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        readingStreak: readingStreak,
        readingDays: readingDays,
        booksCompleted: booksCompleted,
        totalReadingMinutes: totalReadingMinutes,
        lastReadAt: lastReadAt,
        // updatedAt: updatedAt,
      );
      return Result.ok(null);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> updateUserProfile({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
    // DateTime? updatedAt,
  }) async {
    try {
      await remoteDataSource.updateUserProfile(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        avatarFile: avatarFile,
        language: language,
        textScale: textScale,
        darkMode: darkMode,
      );
      return Result.ok(null);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }
}

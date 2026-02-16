import 'dart:io';
import 'package:bookreading/core/connections/network_info.dart';
import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/injection/di/service_locator.dart';
import 'package:bookreading/core/errors/failure/failure.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
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
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> getChapters(int bookId) async {
    try {
      final result = await remoteDataSource.getChapters(bookId);
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> getBookById(int bookId) async {
    try {
      final result = await remoteDataSource.getBookById(bookId);

      if (result == null) {
        return Result.error(UnknownFailure(debugMessage: 'Book not found'));
      }

      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
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
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
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
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> getUserProfile() async {
    try {
      final result = await remoteDataSource.getUserProfile(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );

      //    if (response['avatar_url'] != null) {
      //   response['avatar_url'] = await getAvatar(response['avatar_url'] as String);
      // }
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> updateUserProfile({
    String? avatarUrl,
    String? language,
    double? textScale,
    bool? darkMode,
    // DateTime? updatedAt,
  }) async {
    try {
      await remoteDataSource.updateUserProfile(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
        avatarUrl: avatarUrl,
        language: language,
        textScale: textScale,
        darkMode: darkMode,
      );
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> uploadAvatar({required File avatarFile}) async {
    try {
      final result = await remoteDataSource.uploadAvatar(
        avatarFile: avatarFile,
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );
      return Result.ok(result);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> insertBookmark({
    required int bookId,
    // required double progressPercentage,
  }) async {
    try {
      await remoteDataSource.insertBookmark(bookId: bookId);
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> removeBookmark({required int bookId}) async {
    try {
      await remoteDataSource.removeBookmark(bookId: bookId);
      return Result.ok(null);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> getBookmarks() async {
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

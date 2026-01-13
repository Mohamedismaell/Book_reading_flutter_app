import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:bookreading/features/book/data/datasources/Books_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/connections/network_info.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/repositories/book_repository.dart';

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
}

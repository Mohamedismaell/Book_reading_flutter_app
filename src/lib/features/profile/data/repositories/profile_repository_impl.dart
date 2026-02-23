import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/injection/service_locator.dart';
import 'package:bookreading/features/profile/data/datasources/profile_data_source.dart';
import 'package:bookreading/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bookreading/features/profile/data/models/user_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });
  @override
  Future<Result<UserStatsModel>> getUserStats() async {
    try {
      final result = await remoteDataSource.getUserStats(
        userId: sl<SupabaseClient>().auth.currentUser!.id,
      );
      //   if (result == null) {
      //   return Result.ok(null);
      // }
      return Result.ok(result!);
    } catch (e) {
      final failure = ApiErrorMapper.fromException(e);
      return Result.error(failure);
    }
  }

  @override
  Future<Result> updateUserStats({
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
}

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/profile/data/models/user_stats_model.dart';

//Todo dinihs get user states and diplay it witht the user data cubit and then add the updae and edit
abstract class ProfileRepository {
  Future<Result<UserStatsModel>> getUserStats();

  Future<Result<void>> updateUserStats({
    // required String userId,
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
  });
}

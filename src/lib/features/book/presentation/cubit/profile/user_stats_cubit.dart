import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/user_stats.dart';
import 'package:bookreading/features/book/domain/usecases/get_user_stats.dart';
import 'package:bookreading/features/book/domain/usecases/update_user_stats.dart';
import 'package:meta/meta.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit(this.updateUserStats, this.getUserStats)
    : super(UserStatsInitial());
  final UpdateUserStats updateUserStats;
  final GetUserStats getUserStats;

  Future<void> saveUserStats() async {
    emit(UserStatsLoading());
    final result = await getUserStats.call();
    result.when(
      success: (userStats) => emit(UserStatsLoaded(userStats: userStats)),
      failure: (error) => emit(UserStatsError(message: error.errMessage)),
    );
  }

  Future<void> changeUserStats({
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
  }) async {
    emit(UserStatsLoading());
    final result = await updateUserStats.call(
      // readingStreak: readingStreak,
      readingDays: readingDays,
      booksCompleted: booksCompleted,
      totalReadingMinutes: totalReadingMinutes,
      lastReadAt: lastReadAt,
    );
    result.when(
      success: (_) => emit(UserStatsSaved()),
      failure: (error) => emit(UserStatsError(message: error.errMessage)),
    );
  }
}

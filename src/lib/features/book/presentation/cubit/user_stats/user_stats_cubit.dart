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
    required DateTime lastReadAt,
  }) async {
    // emit(UserStatsLoading());
    if (state is! UserStatsLoaded) return;
    final old = (state as UserStatsLoaded).userStats;

    final newStats = old.copyWith(
      readingStreak: old.readingStreak + (readingStreak ?? 0),
      readingDays: old.readingDays + (readingDays ?? 0),
      booksCompleted: old.booksCompleted + (booksCompleted ?? 0),
      totalReadingMinutes: old.totalReadingMinutes + (totalReadingMinutes ?? 0),
      lastReadAt: lastReadAt,
    );

    final result = await updateUserStats.call(
      readingStreak: newStats.readingStreak,
      readingDays: newStats.readingDays,
      booksCompleted: newStats.booksCompleted,
      totalReadingMinutes: newStats.totalReadingMinutes,
      lastReadAt: newStats.lastReadAt!,
    );
    result.when(
      success: (_) => emit(UserStatsLoaded(userStats: newStats)),
      failure: (error) => emit(UserStatsError(message: error.errMessage)),
    );
  }
}

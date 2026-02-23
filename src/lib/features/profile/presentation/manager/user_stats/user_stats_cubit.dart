import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/profile/data/models/user_stats_model.dart';
import 'package:bookreading/features/profile/domain/usecases/get_user_stats.dart';
import 'package:equatable/equatable.dart';

part 'user_stats_state.dart';

class UserStatsCubit extends Cubit<UserStatsState> {
  UserStatsCubit(this.getUserStats) : super(const UserStatsState());

  // final UpdateUserStats updateUserStats;
  final GetUserStats getUserStats;

  Future<void> fetchUserStats() async {
    emit(state.copyWith(userStateStatus: LoadStatus.loading));
    final result = await getUserStats.call();
    result.when(
      success: (userStats) => emit(
        state.copyWith(
          userStateStatus: LoadStatus.loaded,
          userStats: userStats,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          userStateStatus: LoadStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  // Future<void> changeUserStats({
  //   int? readingStreak,
  //   int? readingDays,
  //   int? booksCompleted,
  //   int? totalReadingMinutes,
  //   required DateTime lastReadAt,
  // }) async {
  //   // emit(UserStatsLoading());
  //   if (state is! UserStatsLoaded) return;
  //   final old = (state as UserStatsLoaded).userStats;

  //   final newStats = old.copyWith(
  //     readingStreak: old.readingStreak + (readingStreak ?? 0),
  //     readingDays: old.readingDays + (readingDays ?? 0),
  //     booksCompleted: old.booksCompleted + (booksCompleted ?? 0),
  //     totalReadingMinutes: old.totalReadingMinutes + (totalReadingMinutes ?? 0),
  //     lastReadAt: lastReadAt,
  //   );

  //   final result = await updateUserStats.call(
  //     readingStreak: newStats.readingStreak,
  //     readingDays: newStats.readingDays,
  //     booksCompleted: newStats.booksCompleted,
  //     totalReadingMinutes: newStats.totalReadingMinutes,
  //     lastReadAt: newStats.lastReadAt!,
  //   );
  //   result.when(
  //     success: (_) => emit(UserStatsLoaded(userStats: newStats)),
  //     failure: (error) => emit(UserStatsError(message: error.message)),
  //   );
  // }
}

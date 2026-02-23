// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_stats_cubit.dart';

class UserStatsState extends Equatable {
  final LoadStatus userStateStatus;
  final UserStatsModel userStats;
  final String? errorMessage;

  const UserStatsState({
    this.userStateStatus = LoadStatus.initial,
    this.userStats = const UserStatsModel(
      readingStreak: 0,
      readingDays: 0,
      booksCompleted: 0,
      booksFavorite: 0,
      totalReadingMinutes: 0,
    ),
    this.errorMessage,
  });

  @override
  List<Object?> get props => [userStateStatus, userStats, errorMessage];

  UserStatsState copyWith({
    LoadStatus? userStateStatus,
    UserStatsModel? userStats,
    String? errorMessage,
  }) {
    return UserStatsState(
      userStateStatus: userStateStatus ?? this.userStateStatus,
      userStats: userStats ?? this.userStats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

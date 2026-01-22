part of 'user_stats_cubit.dart';

@immutable
sealed class UserStatsState {}

final class UserStatsInitial extends UserStatsState {}

final class UserStatsLoading extends UserStatsState {}

final class UserStatsLoaded extends UserStatsState {
  final UserStats userStats;

  UserStatsLoaded({required this.userStats});
}

class UserStatsSaved extends UserStatsState {
  // final double progress;

  // UserStatsSaved({required this.progress});
  // @override
  // List<Object?> get props => [progress];
}

class UserStatsError extends UserStatsState {
  final String message;

  UserStatsError({required this.message});
}

part of 'user_stats_cubit.dart';

@immutable
sealed class UserStatsState {}

final class UserStatsInitial extends UserStatsState {}

final class UserStatsLoading extends UserStatsState {}

final class UserStatsLoaded extends UserStatsState {
  final UserStatsModel userStats;

  UserStatsLoaded({required this.userStats});
}

class UserStatsError extends UserStatsState {
  final String message;

  UserStatsError({required this.message});
}

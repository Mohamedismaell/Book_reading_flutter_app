// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_stats_cubit.dart';

class UserStatsState extends Equatable {
  final LoadStatus userStateStatus;
  final UserStatsModel userStatsModel;
  final String? errorMessage;

  const UserStatsState({
    this.userStateStatus = LoadStatus.initial,
    this.userStatsModel = const UserStatsModel(
      readingStreak: 0,
      readingDays: 0,
      booksCompleted: 0,
      totalReadingMinutes: 0,
    ),
    this.errorMessage,
  });

  @override
  List<Object?> get props => [userStateStatus, userStatsModel, errorMessage];

  UserStatsState copyWith({
    LoadStatus? userStateStatus,
    UserStatsModel? userStatsModel,
    String? errorMessage,
  }) {
    return UserStatsState(
      userStateStatus: userStateStatus ?? this.userStateStatus,
      userStatsModel: userStatsModel ?? this.userStatsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

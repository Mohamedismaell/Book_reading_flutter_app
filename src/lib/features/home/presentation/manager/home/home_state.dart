// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserModel? user;
  final LoadStatus userStatus;
  final String? userErrorMessage;
  final ProgressModel? progress;
  final LoadStatus progressStatus;
  final String? progressErrorMessage;

  const HomeState({
    this.user,
    this.userStatus = LoadStatus.initial,
    this.userErrorMessage = '',
    this.progress,
    this.progressStatus = LoadStatus.initial,
    this.progressErrorMessage = '',
  });

  HomeState copyWith({
    UserModel? user,
    LoadStatus? userStatus,
    String? userErrorMessage,
    ProgressModel? progress,
    LoadStatus? progressStatus,
    String? progressErrorMessage,
  }) {
    return HomeState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
      progress: progress ?? this.progress,
      progressStatus: progressStatus ?? this.progressStatus,
      progressErrorMessage: progressErrorMessage ?? this.progressErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    userStatus,
    userErrorMessage,
    user,
    progressStatus,
    progressErrorMessage,
    progress,
  ];

  // @override
  // String toString() => 'HomeState(userStatus: $userStatus)';

  @override
  bool get stringify => true;
}

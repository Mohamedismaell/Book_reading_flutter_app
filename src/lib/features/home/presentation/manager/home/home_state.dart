// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserModel? user;
  final LoadStatus userStatus;
  final String? userErrorMessage;

  const HomeState({
    this.user,
    this.userStatus = LoadStatus.initial,
    this.userErrorMessage = '',
  });

  HomeState copyWith({
    UserModel? user,
    LoadStatus? userStatus,
    String? userErrorMessage,
  }) {
    return HomeState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
    );
  }

  @override
  List<Object?> get props => [userStatus, userErrorMessage, user];

  // @override
  // String toString() => 'HomeState(userStatus: $userStatus)';

  @override
  bool get stringify => true;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final LoadStatus userStatus;

  const HomeState({required this.userStatus});

  HomeState copyWith({LoadStatus? userStatus}) {
    return HomeState(userStatus: userStatus ?? this.userStatus);
  }

  @override
  List<Object> get props => [userStatus];

  // @override
  // String toString() => 'HomeState(userStatus: $userStatus)';

  @override
  bool get stringify => true;
}

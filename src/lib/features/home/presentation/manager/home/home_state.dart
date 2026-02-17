// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserModel? user;
  final LoadStatus userStatus;
  final String? userErrorMessage;
  final BookModel? book;
  final LoadStatus bookStatus;
  final String? bookErrorMessage;
  const HomeState({
    this.user,
    this.userStatus = LoadStatus.initial,
    this.userErrorMessage = '',
    this.book,
    this.bookStatus = LoadStatus.initial,
    this.bookErrorMessage = '',
  });

  HomeState copyWith({
    UserModel? user,
    LoadStatus? userStatus,
    String? userErrorMessage,
    BookModel? book,
    LoadStatus? bookStatus,
    String? bookErrorMessage,
  }) {
    return HomeState(
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      userErrorMessage: userErrorMessage ?? this.userErrorMessage,
      book: book ?? this.book,
      bookStatus: bookStatus ?? this.bookStatus,
      bookErrorMessage: bookErrorMessage ?? this.bookErrorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      user,
      userStatus,
      userErrorMessage,
      book,
      bookStatus,
      bookErrorMessage,
    ];
  }
}

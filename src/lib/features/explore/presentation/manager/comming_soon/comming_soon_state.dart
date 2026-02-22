// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'comming_soon_cubit.dart';

class CommingSoonState extends Equatable {
  final List<BookModel> books;
  final LoadStatus status;
  final String? message;

  const CommingSoonState({
    this.books = const [],
    this.status = LoadStatus.initial,
    this.message,
  });

  CommingSoonState copyWith({
    List<BookModel>? books,
    LoadStatus? status,
    String? message,
  }) {
    return CommingSoonState(
      books: books ?? this.books,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [books, status, message];
}

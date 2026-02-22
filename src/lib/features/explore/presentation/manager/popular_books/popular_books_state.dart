// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'popular_books_cubit.dart';

class PopularBooksState extends Equatable {
  final List<BookModel> books;
  final LoadStatus status;
  final String? message;

  const PopularBooksState({
    this.books = const [],
    this.status = LoadStatus.initial,
    this.message,
  });

  PopularBooksState copyWith({
    List<BookModel>? books,
    LoadStatus? status,
    String? message,
  }) {
    return PopularBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [books, status, message];
}

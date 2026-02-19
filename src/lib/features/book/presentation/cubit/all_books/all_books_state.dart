part of 'all_books_cubit.dart';

class AllBooksState extends Equatable {
  final List<BookModel> books;
  final LoadStatus status;
  final String? message;

  const AllBooksState({
    this.books = const [],
    this.status = LoadStatus.initial,
    this.message,
  });

  AllBooksState copyWith({
    List<BookModel>? books,
    LoadStatus? status,
    String? message,
  }) {
    return AllBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [books, status, message];
}

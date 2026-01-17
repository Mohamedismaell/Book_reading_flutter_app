part of 'books_cubit.dart';

@immutable
sealed class BooksState {}

final class BooksInitial extends BooksState {}

final class BooksIsLoading extends BooksState {}

final class BooksIsLoaded extends BooksState {
  final List<BookModel> books;

  BooksIsLoaded({required this.books});
}

final class BooksIsFailed extends BooksState {
  final String message;

  BooksIsFailed({required this.message});
}

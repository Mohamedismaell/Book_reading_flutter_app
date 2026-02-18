// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_id_cubit.dart';

sealed class BookIdState extends Equatable {
  // @override
  // List<Object?> get props => [bookStatus, bookErrorMessage, book];
}

final class BookIdInitial extends BookIdState {
  @override
  List<Object?> get props => [];
}

final class BookIdLoading extends BookIdState {
  @override
  List<Object?> get props => [];
}

final class BookIdLoaded extends BookIdState {
  final BookModel? book;

  BookIdLoaded({required this.book});

  @override
  List<Object?> get props => [book];
}

class BookIdError extends BookIdState {
  final String? bookErrorMessage;

  BookIdError({required this.bookErrorMessage});

  @override
  List<Object?> get props => [bookErrorMessage];
}

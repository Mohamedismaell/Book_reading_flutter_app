// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'book_id_cubit.dart';

class BookIdState extends Equatable {
  final BookModel? book;
  final LoadStatus bookStatus;
  final String? bookErrorMessage;

  const BookIdState({
    this.book,
    this.bookStatus = LoadStatus.initial,
    this.bookErrorMessage = '',
  });
  @override
  List<Object?> get props => [bookStatus, bookErrorMessage, book];

  BookIdState copyWith({
    BookModel? book,
    LoadStatus? bookStatus,
    String? bookErrorMessage,
  }) {
    return BookIdState(
      book: book ?? this.book,
      bookStatus: bookStatus ?? this.bookStatus,
      bookErrorMessage: bookErrorMessage ?? this.bookErrorMessage,
    );
  }

  @override
  bool get stringify => true;
}

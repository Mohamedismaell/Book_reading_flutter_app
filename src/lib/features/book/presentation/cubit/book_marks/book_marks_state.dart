part of 'book_marks_cubit.dart';

@immutable
sealed class BookMarksState {}

final class BookMarksInitial extends BookMarksState {}

final class BookMarksLoading extends BookMarksState {}

final class BookMarksLoaded extends BookMarksState {
  final List<BookMarksModel> bookmarks;
  BookMarksLoaded(this.bookmarks);
}

class BookMarkActive extends BookMarksState {
  final int bookId;
  BookMarkActive(this.bookId);
}

class BookMarkInactive extends BookMarksState {
  final int bookId;
  BookMarkInactive(this.bookId);
}

final class BookMarksError extends BookMarksState {
  final String message;
  BookMarksError({required this.message});
}

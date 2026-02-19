part of 'book_marks_cubit.dart';

@immutable
class BookMarksState extends Equatable {
  final List<BookMarksModel> bookmarks;
  final LoadStatus bookmarksStatus;
  final String errorMessage;
  const BookMarksState({
    this.bookmarks = const [],
    this.bookmarksStatus = LoadStatus.initial,
    this.errorMessage = '',
  });

  BookMarksState copyWith({
    List<BookMarksModel>? bookmarks,
    LoadStatus? bookmarksStatus,
    String? errorMessage,
  }) {
    return BookMarksState(
      bookmarks: bookmarks ?? this.bookmarks,
      bookmarksStatus: bookmarksStatus ?? this.bookmarksStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [bookmarks, bookmarksStatus, errorMessage];
}

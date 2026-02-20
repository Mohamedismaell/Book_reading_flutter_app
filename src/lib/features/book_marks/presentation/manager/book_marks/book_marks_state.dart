part of 'book_marks_cubit.dart';

@immutable
class BookMarksState extends Equatable {
  final Set<int> bookmarkedIds;
  final LoadStatus bookmarksStatus;
  final String errorMessage;

  const BookMarksState({
    this.bookmarkedIds = const {},
    this.bookmarksStatus = LoadStatus.initial,
    this.errorMessage = '',
  });

  BookMarksState copyWith({
    Set<int>? bookmarkedIds,
    LoadStatus? bookmarksStatus,
    String? errorMessage,
  }) {
    return BookMarksState(
      bookmarkedIds: bookmarkedIds ?? this.bookmarkedIds,
      bookmarksStatus: bookmarksStatus ?? this.bookmarksStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isBookmarked(int bookId) {
    return bookmarkedIds.contains(bookId);
  }

  @override
  List<Object?> get props => [bookmarkedIds, bookmarksStatus, errorMessage];
}

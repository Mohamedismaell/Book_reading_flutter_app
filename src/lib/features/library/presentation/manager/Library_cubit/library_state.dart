// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_cubit.dart';

class LibraryState extends Equatable {
  final List<BookMarksModel> bookMarksBooks;
  final List<BookModel> finishedBooks;
  final LoadStatus status;
  final String? errorMessage;
  bool isFavoriteScreen;
  LibraryState({
    this.bookMarksBooks = const [],
    this.finishedBooks = const [],
    this.status = LoadStatus.initial,
    this.errorMessage,
    this.isFavoriteScreen = true,
  });

  @override
  List<Object?> get props => [
    bookMarksBooks,
    status,
    errorMessage,
    isFavoriteScreen,
    finishedBooks,
  ];

  LibraryState copyWith({
    List<BookMarksModel>? bookMarksBooks,
    LoadStatus? status,
    String? errorMessage,
    bool? isFavoriteScreen,
    List<BookModel>? finishedBooks,
  }) {
    return LibraryState(
      bookMarksBooks: bookMarksBooks ?? this.bookMarksBooks,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavoriteScreen: isFavoriteScreen ?? this.isFavoriteScreen,
      finishedBooks: finishedBooks ?? this.finishedBooks,
    );
  }
}

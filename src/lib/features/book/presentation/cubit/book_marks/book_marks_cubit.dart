import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/book_marks.dart';
import 'package:bookreading/features/book/domain/usecases/book_marks.dart';
import 'package:meta/meta.dart';

part 'book_marks_state.dart';

class BookMarksCubit extends Cubit<BookMarksState> {
  BookMarksCubit(this.insertBookMark, this.removeBookMark, this.getBookMarks)
    : super(BookMarksInitial());
  final InsertBookMarks insertBookMark;
  final RemoveBookMarks removeBookMark;
  final GetBookMarks getBookMarks;
  Future<void> saveBookMark({required int bookId}) async {
    final result = await insertBookMark.call(bookId: bookId);
    result.when(
      success: (_) => emit(BookMarkActive(bookId)),
      failure: (failure) => emit(BookMarksError(message: failure.errMessage)),
    );
  }

  Future<void> removeBookmark({required int bookId}) async {
    final currentState = state;
    List<BookMarksModel> oldList = [];
    if (currentState is BookMarksLoaded) {
      oldList = currentState.bookmarks;
      final newList = oldList
          .where((book) => book.bookDetails?.id != bookId)
          .toList();
      emit(BookMarksLoaded(newList));
    }
    final result = await removeBookMark.call(bookId: bookId);
    result.when(
      success: (_) {},
      failure: (failure) {
        emit(BookMarksLoaded(oldList));
        // emit(
        //   BookMarksError(message: "Failed to remove bookmark. Check internet."),
        // );
        emit(BookMarksError(message: failure.errMessage));
      },
    );
  }

  Future<void> fetchAllBookmarks() async {
    emit(BookMarksLoading());
    final result = await getBookMarks.call();

    result.when(
      success: (booksList) => emit(BookMarksLoaded(booksList)),
      failure: (failure) => emit(BookMarksError(message: failure.errMessage)),
    );
  }
}

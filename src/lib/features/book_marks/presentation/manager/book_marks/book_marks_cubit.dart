import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks.dart';
import 'package:bookreading/features/book_marks/domain/usecases/insert_book_marks.dart';
import 'package:bookreading/features/book_marks/domain/usecases/remove_book_marks.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_marks_state.dart';

class BookMarksCubit extends Cubit<BookMarksState> {
  BookMarksCubit(this.insertBookMark, this.removeBookMark, this.getBookMarks)
    : super(const BookMarksState());
  final InsertBookMarks insertBookMark;
  final RemoveBookMarks removeBookMark;
  final GetBookMarks getBookMarks;

  Future<void> saveBookMark({required int bookId}) async {
    final result = await insertBookMark.call(bookId: bookId);
    result.when(
      success: (_) {
        // emit(state.copyWith(bookmarksStatus: LoadStatus.loaded));
      },
      failure: (failure) => emit(
        state.copyWith(
          bookmarksStatus: LoadStatus.error,
          errorMessage: failure.message,
        ),
      ),
    );
  }

  Future<void> getAllBookmarks() async {
    emit(state.copyWith(bookmarksStatus: LoadStatus.loading));
    final result = await getBookMarks.call();

    result.when(
      success: (booksList) => emit(
        state.copyWith(
          bookmarks: booksList,
          bookmarksStatus: LoadStatus.loaded,
        ),
      ),
      failure: (failure) => emit(
        state.copyWith(
          bookmarksStatus: LoadStatus.error,
          errorMessage: failure.message,
        ),
      ),
    );
  }

  Future<void> removeBookmark({required int bookId}) async {
    final copyList = state.bookmarks
        .where((element) => element.bookDetails?.id != bookId)
        .toList();

    final result = await removeBookMark.call(bookId: bookId);
    result.when(
      success: (_) {},
      failure: (failure) {
        emit(
          state.copyWith(
            bookmarks: copyList,
            bookmarksStatus: LoadStatus.loaded,
          ),
        );
        emit(
          state.copyWith(
            bookmarksStatus: LoadStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }
}

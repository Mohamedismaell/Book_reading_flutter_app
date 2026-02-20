import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks.dart';
import 'package:bookreading/features/progress/domain/usecases/get_finished_books.dart';
import 'package:equatable/equatable.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this.getBookMarks, this.getFinishedBooks)
    : super(LibraryState());

  final GetBookMarksBooks getBookMarks;
  final GetFinishedBooks getFinishedBooks;
  void changeCall() {
    if (state.isFavoriteScreen) {
      fetchAllBookmarks();
    } else {
      fetchFinishedBooks();
    }
  }

  Future<void> fetchAllBookmarks() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await getBookMarks.call();

    result.when(
      success: (booksList) => emit(
        state.copyWith(bookMarksBooks: booksList, status: LoadStatus.loaded),
      ),
      failure: (failure) => emit(
        state.copyWith(status: LoadStatus.error, errorMessage: failure.message),
      ),
    );
  }

  Future<void> fetchFinishedBooks() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await getFinishedBooks.call();

    result.when(
      success: (booksList) => emit(
        state.copyWith(finishedBooks: booksList, status: LoadStatus.loaded),
      ),
      failure: (failure) => emit(
        state.copyWith(status: LoadStatus.error, errorMessage: failure.message),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book_marks/domain/usecases/get_book_marks_id.dart';
import 'package:bookreading/features/book_marks/domain/usecases/insert_book_marks.dart';
import 'package:bookreading/features/book_marks/domain/usecases/remove_book_marks.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_marks_state.dart';

class BookMarksCubit extends Cubit<BookMarksState> {
  BookMarksCubit(this.insertBookMark, this.removeBookMark, this.getBookMarksId)
    : super(const BookMarksState());
  final InsertBookMarks insertBookMark;
  final RemoveBookMarks removeBookMark;
  final GetBookMarksId getBookMarksId;
  void fetchBookMarksId() async {
    emit(state.copyWith(bookmarksStatus: LoadStatus.loading));
    final result = await getBookMarksId.call();
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            bookmarkedIds: data,
            bookmarksStatus: LoadStatus.loaded,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            bookmarksStatus: LoadStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  void toggleBookmark({required int bookId}) async {
    final previousIds = Set<int>.from(state.bookmarkedIds);
    final updatedIds = Set<int>.from(state.bookmarkedIds);

    final isBookMarked = updatedIds.contains(bookId);

    if (isBookMarked) {
      updatedIds.remove(bookId);
    } else {
      updatedIds.add(bookId);
    }
    emit(state.copyWith(bookmarkedIds: updatedIds));

    final result = isBookMarked
        ? await removeBookMark(bookId: bookId)
        : await insertBookMark(bookId: bookId);

    result.when(
      success: (_) {},
      failure: (failure) {
        emit(
          state.copyWith(
            bookmarkedIds: previousIds,
            bookmarksStatus: LoadStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }
}

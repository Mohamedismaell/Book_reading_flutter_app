import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/domain/usecases/book_marks.dart';
import 'package:meta/meta.dart';

part 'book_marks_state.dart';

class BookMarksCubit extends Cubit<BookMarksState> {
  BookMarksCubit(this.insertBookMark, this.removeBookMark)
    : super(BookMarksInitial());
  final InsertBookMark insertBookMark;
  final RemoveBookMark removeBookMark;
  Future<void> saveBookMark({required int bookId}) async {
    final result = await insertBookMark.call(bookId: bookId);
    result.when(
      success: (_) => emit(BookMarkActive(bookId)),
      failure: (failure) => emit(BookMarksError(message: failure.errMessage)),
    );
  }

  Future<void> removeBookmark({required int bookId}) async {
    final result = await removeBookMark.call(bookId: bookId);
    result.when(
      success: (_) => emit(BookMarkInactive(bookId)),
      failure: (failure) => emit(BookMarksError(message: failure.errMessage)),
    );
  }
}

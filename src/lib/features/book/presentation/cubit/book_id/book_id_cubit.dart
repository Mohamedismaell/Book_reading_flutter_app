import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:equatable/equatable.dart';
part 'book_id_state.dart';

class BookIdCubit extends Cubit<BookIdState> {
  BookIdCubit(this.getBookByIdUseCase) : super(BookIdState());
  final GetBookByIdUseCase getBookByIdUseCase;
  Future<void> loadBook(int bookId) async {
    if (!isClosed) {
      emit(state.copyWith(bookStatus: LoadStatus.loading));
    }
    final result = await getBookByIdUseCase.call(bookId);
    result.when(
      success: (book) => {
        if (!isClosed)
          {emit(state.copyWith(book: book, bookStatus: LoadStatus.loaded))},
      },

      failure: (failure) => {
        if (!isClosed)
          {
            emit(
              state.copyWith(
                bookStatus: LoadStatus.error,
                bookErrorMessage: failure.message,
              ),
            ),
          },
      },
    );
  }
}

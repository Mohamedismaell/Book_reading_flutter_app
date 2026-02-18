import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:equatable/equatable.dart';
part 'book_id_state.dart';

class BookIdCubit extends Cubit<BookIdState> {
  BookIdCubit(this.getBookByIdUseCase) : super(BookIdInitial());
  final GetBookByIdUseCase getBookByIdUseCase;

  Future<void> loadBook(int bookId) async {
    if (isClosed) return;
    emit(BookIdLoading());
    print('state loading');

    final result = await getBookByIdUseCase.call(bookId);
    result.when(
      success: (book) => {
        emit(BookIdLoaded(book: book)),
        print('state loaded'),
      },

      failure: (failure) => {
        emit(BookIdError(bookErrorMessage: failure.message)),
        print('state error'),
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:meta/meta.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit(this.getBookByIdUseCase) : super(BookInitial());
  final GetBooksIdUseCase getBookByIdUseCase;
  Future<void> loadBook(int bookId) async {
    emit(BookLoading());
    final result = await getBookByIdUseCase.call(bookId);
    result.when(
      success: (book) => emit(BookLoaded(book: book)),
      failure: (failure) => emit(BookError(message: failure.errMessage)),
    );
  }
}

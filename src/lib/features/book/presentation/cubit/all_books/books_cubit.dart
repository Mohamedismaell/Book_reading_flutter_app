import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:meta/meta.dart';
part 'books_state.dart';

class AllBooksCubit extends Cubit<BooksState> {
  final GetBooksUseCase getBooksUseCase;

  AllBooksCubit(this.getBooksUseCase) : super(BooksInitial());

  Future<void> getBooks() async {
    emit(BooksIsLoading());
    final result = await getBooksUseCase.call();
    result.when(
      success: (books) => emit(BooksIsLoaded(books: books)),
      failure: (failure) => emit(BooksIsFailed(message: failure.message)),
    );
  }
}

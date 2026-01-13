import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/usecases/get_books_usecase.dart';
import 'package:bookreading/features/book/domain/usecases/get_chapters_usecase.dart';
import 'package:meta/meta.dart';
part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  final GetBooksUseCase getBooksUseCase;
  final GetChaptersUseCase getChaptersUseCase;
  BooksCubit(this.getBooksUseCase, this.getChaptersUseCase)
    : super(BooksInitial());

  Future<void> getBooks() async {
    emit(BooksIsLoading());
    final result = await getBooksUseCase.call();
    result.when(
      success: (books) => emit(BooksIsLoaded(books: books)),
      failure: (failure) => emit(BooksIsFailed(message: failure.errMessage)),
    );
  }

  Future<void> getChapters(int bookId) async {
    emit(ChapterIsLoading());
    final result = await getChaptersUseCase.call(bookId);
    result.when(
      success: (chapters) => emit(ChapterIsLoaded(chapters: chapters)),
      failure: (failure) => emit(ChapterIsFaild(message: failure.errMessage)),
    );
  }
}

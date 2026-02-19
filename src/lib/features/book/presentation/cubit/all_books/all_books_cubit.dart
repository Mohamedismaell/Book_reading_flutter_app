import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/book/domain/usecases/books_usecase.dart';
import 'package:equatable/equatable.dart';

part 'all_books_state.dart';

class AllBooksCubit extends Cubit<AllBooksState> {
  AllBooksCubit(this.getAllBooksUseCase) : super(const AllBooksState());
  final GetAllBooksUseCase getAllBooksUseCase;

  Future<void> loadBooks() async {
    emit(state.copyWith(status: LoadStatus.loading));

    final result = await getAllBooksUseCase.call();

    result.when(
      success: (books) =>
          emit(state.copyWith(books: books, status: LoadStatus.loaded)),
      failure: (f) =>
          emit(state.copyWith(status: LoadStatus.error, message: f.message)),
    );
  }
}

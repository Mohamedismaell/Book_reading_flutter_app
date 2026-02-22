import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/explore/domain/usecases/get_popular_books.dart';
import 'package:equatable/equatable.dart';

part 'popular_books_state.dart';

class PopularBooksCubit extends Cubit<PopularBooksState> {
  PopularBooksCubit({required this.getPopularBooks})
    : super(const PopularBooksState());
  final GetPopularBooks getPopularBooks;

  Future<void> fetchPopularBooks() async {
    emit(state.copyWith(status: LoadStatus.loading));

    final result = await getPopularBooks.call();

    result.when(
      success: (books) =>
          emit(state.copyWith(books: books, status: LoadStatus.loaded)),
      failure: (f) =>
          emit(state.copyWith(status: LoadStatus.error, message: f.message)),
    );
  }
}

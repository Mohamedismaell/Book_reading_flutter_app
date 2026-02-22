import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:bookreading/features/explore/domain/usecases/get_comming_soon_books.dart';
import 'package:equatable/equatable.dart';

part 'comming_soon_state.dart';

class CommingSoonCubit extends Cubit<CommingSoonState> {
  CommingSoonCubit({required this.getCommingSoonBooks})
    : super(const CommingSoonState());

  final GetCommingSoonBooks getCommingSoonBooks;
  Future<void> fetchCommingSoonBooks() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await getCommingSoonBooks.call();
    result.when(
      success: (books) =>
          emit(state.copyWith(books: books, status: LoadStatus.loaded)),
      failure: (f) =>
          emit(state.copyWith(status: LoadStatus.error, message: f.message)),
    );
  }
}

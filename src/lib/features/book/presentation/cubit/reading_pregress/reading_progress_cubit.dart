import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/user_progress.dart';
import 'package:bookreading/features/book/domain/usecases/insert_reading_pregress.dart';
import 'package:meta/meta.dart';

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  ReadingProgressCubit(this.insertReadingPregress)
    : super(ReadingProgressInitial());
  final InsertReadingPregress insertReadingPregress;
  Future<void> saveProgress({
    required int bookId,
    required String userId,
    required String chapterId,
    required int currentPage,
    required int totalPages,
  }) async {
    emit(ReadingProgressInitial());
    final result = await insertReadingPregress.call(
      bookId,
      userId,
      chapterId,
      currentPage,
    );
    result.when(
      success: (progress) {
        print(' succes');
        emit(ReadingProgressSaved());
      },
      failure: (failure) =>
          emit(ReadingProgressError(message: failure.errMessage)),
    );
  }
}

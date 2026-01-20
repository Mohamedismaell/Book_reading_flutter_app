import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/data/models/user_progress.dart';
import 'package:bookreading/features/book/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/book/domain/usecases/insert_reading_pregress.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  ReadingProgressCubit(this.insertReadingPregress, this.getReadingProgress)
    : super(ReadingProgressInitial());
  final InsertReadingPregress insertReadingPregress;
  final GetReadingProgress getReadingProgress;
  Future<void> saveProgress({
    required int bookId,
    required String chapterId,
    required double progressPercentage,
    BookModel? activeBook,
    ChapterModel? activeChapter,
  }) async {
    double progressToSave = progressPercentage;
    String chapterIdToSave = chapterId;
    BookModel? bookDetailsToSave = activeBook;
    ChapterModel? chapterDetailsToSave = activeChapter;

    if (state is ReadingProgressLoaded) {
      final oldState = (state as ReadingProgressLoaded).progress;
      if (oldState.bookId == bookId) {
        final oldPercentage = oldState.progressPercentage;

        if (oldPercentage > progressToSave) {
          progressToSave = oldPercentage;

          if (oldState.chapterDetails != null) {
            chapterDetailsToSave = oldState.chapterDetails;
          }
        }
      }
    }
    final result = await insertReadingPregress.call(
      bookId: bookId,
      chapterId: chapterIdToSave,
      progressPercentage: progressToSave,
    );

    result.when(
      success: (_) {
        if (bookDetailsToSave == null && state is ReadingProgressLoaded) {
          bookDetailsToSave =
              (state as ReadingProgressLoaded).progress.bookDetails;
          chapterDetailsToSave =
              (state as ReadingProgressLoaded).progress.chapterDetails;
        }

        // print(
        //   'Saving: Ch $chapterIdToSave at ${(progressToSave * 100).toStringAsFixed(1)}%',
        // );

        final newProgress = UserProgressModel(
          bookId: bookId,
          updatedAt: DateTime.now(),
          chapterId: chapterIdToSave,
          progressPercentage: progressToSave,
          bookDetails: bookDetailsToSave,
          chapterDetails: chapterDetailsToSave,
        );
        emit(ReadingProgressLoaded(progress: newProgress, justSaved: true));
      },
      failure: (failure) =>
          emit(ReadingProgressError(message: failure.errMessage)),
    );
  }

  Future<void> loadProgress() async {
    emit(ReadingProgressLoading());
    final result = await getReadingProgress.call();
    result.when(
      success: (progress) {
        emit(ReadingProgressLoaded(progress: progress, justSaved: false));
      },
      failure: (failure) =>
          emit(ReadingProgressError(message: failure.errMessage)),
    );
  }
}
